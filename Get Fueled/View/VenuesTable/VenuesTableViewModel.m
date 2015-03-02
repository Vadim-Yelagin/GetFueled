//
//  VenuesTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareService.h"
#import "Fueled.h"
#import "Venue.h"
#import "VenuesTableViewModel.h"
#import <CoreData/CoreData.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation VenuesTableViewModel

- (instancetype)init
{
    NSManagedObjectContext *moc = [FoursquareService sharedService].mainMOC;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    request.predicate = [NSPredicate predicateWithFormat:@"actual == YES && thumbsDown == NO"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES]];
    self = [super initWithFetchRequest:request
                  managedObjectContext:moc
                    sectionNameKeyPath:nil
                             cacheName:nil];
    {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[FoursquareService sharedService] exploreWithLatitude:FueledLatitude
                                                                longitude:FueledLongitude
                                                                  section:@"food"
                                                                    limit:50];
        }];
    }
    return self;
}

- (BOOL)canDeleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    Venue *venue = [self itemAtIndexPath:indexPath];
    venue.thumbsDown = YES;
    [[FoursquareService sharedService] saveChanges];
}

@end
