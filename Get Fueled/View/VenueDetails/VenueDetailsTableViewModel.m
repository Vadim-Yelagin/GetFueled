//
//  VenueDetailsTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareService.h"
#import "MapCellModel.h"
#import "Review.h"
#import "TextViewCellModel.h"
#import "Venue.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewModel.h"
#import <ETRCollectionModel/ETRFetchedResultsCollectionModel.h>
#import <ETRCollectionModel/ETRHidingCollectionModel.h>
#import <ETRCollectionModel/ETRStaticCollectionModel.h>
#import <ETRCollectionModel/ETRStaticCellModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueDetailsTableViewModel ()

@property (nonatomic, strong) TextViewCellModel *aNewReviewTextView;
@property (nonatomic, strong) id addReviewItem;

@end

@implementation VenueDetailsTableViewModel

- (instancetype)initWithVenue:(Venue *)venue
{
    VenueDetailsOverviewCellModel *overview = [[VenueDetailsOverviewCellModel alloc] initWithVenue:venue];

    MapCellModel *map = [[MapCellModel alloc] init];
    map.latitude = venue.latitude;
    map.longitude = venue.longitude;
    
    TextViewCellModel *newReviewTextView = [[TextViewCellModel alloc] init];
    newReviewTextView.placeholder = @"Write a review";
    ETRStaticCellModel *addReview = [[ETRStaticCellModel alloc] initWithReuseIdentifier:@"AddReviewCell"];
    
    ETRStaticCollectionModel *header = [[ETRStaticCollectionModel alloc] initWithSections:@[@[overview, map, newReviewTextView]]];
    ETRStaticCollectionModel *addReviewCollection = [[ETRStaticCollectionModel alloc] initWithSections:@[@[addReview]]];
    ETRHidingCollectionModel *addReviewHiding = [[ETRHidingCollectionModel alloc] initWithCollection:addReviewCollection];
    
    NSManagedObjectContext *moc = venue.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Review"];
    request.predicate = [NSPredicate predicateWithFormat:@"venue == %@", venue];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:NO]];
    ETRFetchedResultsCollectionModel *reviews = [[ETRFetchedResultsCollectionModel alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    reviews.allowDelete = YES;
    
    self = [super initWithCollections:@[header, addReviewHiding, reviews]];
    if (self) {
        _venue = venue;
        _aNewReviewTextView = newReviewTextView;
        _addReviewItem = addReview;
        RACSignal *newReviewText = RACObserve(newReviewTextView, text);
        RACSignal *newReviewTextEmpty = [newReviewText map:^id(NSString *value) {
            NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            return @([value stringByTrimmingCharactersInSet:set].length == 0);
        }];
        RAC(addReviewHiding, hidden, @YES) = newReviewTextEmpty;
    }
    return self;
}

- (void)addReviewWithText:(NSString *)text
{
    NSManagedObjectContext *moc = self.venue.managedObjectContext;
    if (!moc)
        return;
    Review *review = [NSEntityDescription insertNewObjectForEntityForName:@"Review" inManagedObjectContext:moc];
    review.dateCreated = [NSDate date];
    review.text = text;
    review.venue = self.venue;
    [[FoursquareService sharedService] saveChanges];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                      completion:(void (^)(void))completion
{
    id item = [self itemAtIndexPath:indexPath];
    if (item == self.addReviewItem) {
        [self addReviewWithText:self.aNewReviewTextView.text];
        [self.aNewReviewTextView endEditing];
        self.aNewReviewTextView.text = @"";
        if (completion)
            completion();
    }
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    [super deleteItemAtIndexPath:indexPath];
    // standard delete for reviews does not save changes
    [[FoursquareService sharedService] saveChanges];
}

@end
