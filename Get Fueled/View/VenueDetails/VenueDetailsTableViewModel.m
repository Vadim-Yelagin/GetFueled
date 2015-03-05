//
//  VenueDetailsTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ButtonCellModel.h"
#import "FoursquareService.h"
#import "MapCellModel.h"
#import "Review.h"
#import "TextViewCellModel.h"
#import "Venue.h"
#import "VenueDetailsInfoCellModel.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewModel.h"
#import <ETRCollectionModel/ETRFetchedResultsCollectionModel.h>
#import <ETRCollectionModel/ETRHidingCollectionModel.h>
#import <ETRCollectionModel/ETRStaticCollectionModel.h>
#import <ETRCollectionModel/ETRStaticCellModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueDetailsTableViewModel ()

@property (nonatomic, strong) TextViewCellModel *aNewReviewTextView;

@end

@implementation VenueDetailsTableViewModel

- (instancetype)initWithVenue:(Venue *)venue
{
    if (!venue) {
        ETRStaticCellModel *noContentCell = [[ETRStaticCellModel alloc] initWithReuseIdentifier:@"NoContentCell"];
        ETRStaticCollectionModel *noContent = [[ETRStaticCollectionModel alloc] initWithSections:@[@[noContentCell]]];
        self = [super initWithCollections:@[noContent]];
        if (self) {
            _noContentItem = noContentCell;
        }
        return self;
    }
    
    VenueDetailsOverviewCellModel *overview = [[VenueDetailsOverviewCellModel alloc] initWithVenue:venue];

    MapCellModel *map = [[MapCellModel alloc] init];
    map.latitude = venue.latitude;
    map.longitude = venue.longitude;
    
    VenueDetailsInfoCellModel *info = [[VenueDetailsInfoCellModel alloc] initWithVenue:venue];
    
    TextViewCellModel *newReviewTextView = [[TextViewCellModel alloc] init];
    newReviewTextView.placeholder = @"Write a review";
    ButtonCellModel *addReview = [[ButtonCellModel alloc] init];
    addReview.title = @"Add Review";
    
    NSMutableArray *urlButtons = [NSMutableArray array];
    void (^addURLButton)(NSString *, NSString *) = ^(NSString *urlString, NSString *title)
    {
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url)
            return;
        ButtonCellModel *button = [[ButtonCellModel alloc] init];
        button.title = title;
        button.action = ^{
            [[UIApplication sharedApplication] openURL:url];
        };
        [urlButtons addObject:button];
    };
    addURLButton(venue.siteURL, venue.siteURL);
    addURLButton(venue.menuURL, @"Menu");
    addURLButton(venue.reservationsURL, @"Reservations");
    
    ButtonCellModel *thumbsDown = [[ButtonCellModel alloc] init];
    
    ETRStaticCollectionModel *header = [[ETRStaticCollectionModel alloc] initWithSections:@[@[overview, info, map], urlButtons, @[thumbsDown, newReviewTextView]]];
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
        RACSignal *newReviewText = RACObserve(newReviewTextView, text);
        RACSignal *newReviewTextEmpty = [newReviewText map:^id(NSString *value) {
            NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            return @([value stringByTrimmingCharactersInSet:set].length == 0);
        }];
        RAC(addReviewHiding, hidden, @YES) = newReviewTextEmpty;
        RAC(thumbsDown, title) = [RACObserve(self, venue.thumbsDown)
                                  map:^NSString *(NSNumber *value)
                                  {
                                      return value.boolValue ? @"Un-Thumbs-Down" : @"Thumbs-Down";
                                  }];
        
        @weakify(self);
        addReview.action = ^{
            @strongify(self);
            [self addReview];
        };
        thumbsDown.action = ^{
            @strongify(self);
            [self toggleThumbsDown];
        };
    }
    return self;
}

- (void)toggleThumbsDown
{
    self.venue.thumbsDown = !self.venue.thumbsDown;
    [[FoursquareService sharedService] saveChanges];
}

- (void)addReview
{
    NSManagedObjectContext *moc = self.venue.managedObjectContext;
    if (!moc)
        return;
    Review *review = [NSEntityDescription insertNewObjectForEntityForName:@"Review"
                                                   inManagedObjectContext:moc];
    review.dateCreated = [NSDate date];
    review.text = self.aNewReviewTextView.text;
    review.venue = self.venue;
    [[FoursquareService sharedService] saveChanges];
    [self.aNewReviewTextView endEditing];
    self.aNewReviewTextView.text = @"";
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                      completion:(void (^)(void))completion
{
    id item = [self itemAtIndexPath:indexPath];
    if ([item isKindOfClass:[ButtonCellModel class]]) {
        ButtonCellModel *button = item;
        if (button.action)
            button.action();
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
