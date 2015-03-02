//
//  FoursquareService.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareResponseGroup.h"
#import "FoursquareResponseItem.h"
#import "FoursquareService.h"
#import "Venue.h"
#import <ETRUtils/ETRUtils.h>
#import <CoreData/CoreData.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RestKit/RestKit.h>

static NSString * const FoursquareBaseURL = @"https://api.foursquare.com/v2/";
static NSString * const FoursquareVersion = @"20150301";
static NSString * const FoursquareClientID = @"4CDCSVPSKFGVZY3K4KM1XMGVIB41GQMYEVU5AHEZGHTKUDJO";
static NSString * const FoursquareClientSecret = @"EQLCFBSLOWS243E1MCVKKMFYB0VJVDJ1FBZEA32JNGHMXV53";

@interface FoursquareService ()

@property (strong, nonatomic) RKObjectManager *objectManager;
@property (strong, nonatomic) RKManagedObjectStore *managedObjectStore;

@property (strong, nonatomic) RKObjectMapping *groupMapping;
@property (strong, nonatomic) RKObjectMapping *itemMapping;
@property (strong, nonatomic) RKEntityMapping *venueMapping;
@property (strong, nonatomic) RKEntityMapping *venueCategoryMapping;

@end

@implementation FoursquareService

+ (instancetype)sharedService
{
    static FoursquareService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addAllRequestDescriptors];
        [self addAllResponseDescriptors];
    }
    return self;
}

- (RKManagedObjectStore *)managedObjectStore
{
    if (_managedObjectStore)
        return _managedObjectStore;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                              withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    _managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    [_managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Model.sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [_managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                      fromSeedDatabaseAtPath:nil
                                                                           withConfiguration:nil
                                                                                     options:nil
                                                                                       error:&error];
    if (!persistentStore && [[NSFileManager defaultManager] removeItemAtPath:storePath error:&error]) {
        persistentStore = [_managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                       fromSeedDatabaseAtPath:nil
                                                            withConfiguration:nil
                                                                      options:nil
                                                                        error:&error];
    }
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    [_managedObjectStore createManagedObjectContexts];
    return _managedObjectStore;
}

- (RKObjectManager *)objectManager
{
    if (_objectManager)
        return _objectManager;
    
    NSURL *baseURL = [NSURL URLWithString:FoursquareBaseURL];
    AFHTTPClient* client = [AFHTTPClient clientWithBaseURL:baseURL];
    _objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    _objectManager.managedObjectStore = self.managedObjectStore;
    _objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    return _objectManager;
}

- (NSManagedObjectContext *)mainMOC
{
    return self.managedObjectStore.mainQueueManagedObjectContext;
}

- (void)saveChanges
{
    NSError* error;
    [self.managedObjectStore.mainQueueManagedObjectContext saveToPersistentStore:&error];
    if (error)
        NSLog(@"Error saving changes to persistent store: %@", error);
}

- (void)markActualVenuesWithGroups:(NSArray *)groups
{
    NSArray *venueIDs = [groups etr_flatMap:^NSArray *(FoursquareResponseGroup *obj) {
        return [obj.items etr_map:^id(FoursquareResponseItem *obj) {
            return obj.venue.identifier;
        }];
    }];
    NSSet *venueIDSet = [NSSet setWithArray:venueIDs];
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    NSArray *allObjects = [[self mainMOC] executeFetchRequest:request
                                                        error:nil];
    for (Venue* object in allObjects) {
        object.actual = [venueIDSet containsObject:object.identifier];
    }
    [self saveChanges];
}

#pragma mark Requests

- (RACSignal *)exploreWithLatitude:(double)latitude
                         longitude:(double)longitude
                           section:(NSString *)section
                             limit:(NSInteger)limit
{
    NSString *path = @"venues/explore";
    NSString *ll = [NSString stringWithFormat:@"%lf,%lf", latitude, longitude];
    NSDictionary *parameters = @{@"client_id": FoursquareClientID,
                                 @"client_secret": FoursquareClientSecret,
                                 @"v": FoursquareVersion,
                                 @"ll": ll,
                                 @"section": section,
                                 @"limit": @(limit)};
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        RKObjectRequestOperation *operation = [self.objectManager appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:path parameters:parameters];
        [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation,
                                                   RKMappingResult *mappingResult)
         {
             @strongify(self);
             [self markActualVenuesWithGroups:mappingResult.array];
             [subscriber sendNext:mappingResult.array];
             [subscriber sendCompleted];
         } failure:^(RKObjectRequestOperation *operation,
                     NSError *error)
         {
             [subscriber sendError:error];
         }];
        [self.objectManager enqueueObjectRequestOperation:operation];
        @weakify(operation);
        return [RACDisposable disposableWithBlock:^{
            @strongify(operation);
            [operation cancel];
        }];
    }];
}

#pragma mark Request descriptors

- (void)addAllRequestDescriptors
{
}

#pragma mark Response descriptors

- (void)addAllResponseDescriptors
{
    [self addExploreResponseDescriptor];
}

- (void)addExploreResponseDescriptor
{
    RKResponseDescriptor *d;
    d = [RKResponseDescriptor responseDescriptorWithMapping:self.groupMapping
                                                     method:RKRequestMethodGET
                                                pathPattern:@"venues/explore"
                                                    keyPath:@"response.groups"
                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:d];
}

#pragma mark Entity Mappings

- (RKObjectMapping *)groupMapping
{
    if (_groupMapping)
        return _groupMapping;
    _groupMapping = [RKObjectMapping mappingForClass:[FoursquareResponseGroup class]];
    [_groupMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"items" toKeyPath:@"items" withMapping:self.itemMapping]];
    return _groupMapping;
}

- (RKObjectMapping *)itemMapping
{
    if (_itemMapping)
        return _itemMapping;
    _itemMapping = [RKObjectMapping mappingForClass:[FoursquareResponseItem class]];
    [_itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"venue" toKeyPath:@"venue" withMapping:self.venueMapping]];
    return _itemMapping;
}

- (RKEntityMapping *)venueMapping
{
    if (_venueMapping)
        return _venueMapping;
    _venueMapping = [RKEntityMapping mappingForEntityForName:@"Venue"
                                        inManagedObjectStore:self.managedObjectStore];
    _venueMapping.identificationAttributes = @[@"identifier"];
    [_venueMapping addAttributeMappingsFromDictionary:@{@"id": @"identifier",
                                                        @"location.distance": @"distance",
                                                        @"hours.isOpen": @"isOpen",
                                                        @"hours.status": @"isOpenStatus"}];
    [_venueMapping addAttributeMappingsFromArray:@[@"name", @"rating", @"ratingColor"]];
    [_venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"categories" toKeyPath:@"categories" withMapping:self.venueCategoryMapping]];
    return _venueMapping;
}

- (RKEntityMapping *)venueCategoryMapping
{
    if (_venueCategoryMapping)
        return _venueCategoryMapping;
    _venueCategoryMapping = [RKEntityMapping mappingForEntityForName:@"VenueCategory"
                                                inManagedObjectStore:self.managedObjectStore];
    _venueCategoryMapping.identificationAttributes = @[@"identifier"];
    [_venueCategoryMapping addAttributeMappingsFromDictionary:@{@"id": @"identifier"}];
    [_venueCategoryMapping addAttributeMappingsFromArray:@[@"name"]];
    return _venueCategoryMapping;
}

@end
