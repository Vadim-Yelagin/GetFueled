//
//  VenueDetailsTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TextViewCellModel.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewModel.h"
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

    TextViewCellModel *newReviewTextView = [[TextViewCellModel alloc] init];
    newReviewTextView.placeholder = @"Write a review";
    ETRStaticCellModel *addReview = [[ETRStaticCellModel alloc] initWithReuseIdentifier:@"AddReviewCell"];
    
    ETRStaticCollectionModel *header = [[ETRStaticCollectionModel alloc] initWithSections:@[@[overview, newReviewTextView]]];
    ETRStaticCollectionModel *addReviewCollection = [[ETRStaticCollectionModel alloc] initWithSections:@[@[addReview]]];
    ETRHidingCollectionModel *addReviewHiding = [[ETRHidingCollectionModel alloc] initWithCollection:addReviewCollection];
    
    self = [super initWithCollections:@[header, addReviewHiding]];
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

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                      completion:(void (^)(void))completion
{
    id item = [self itemAtIndexPath:indexPath];
    if (item == self.addReviewItem) {
        self.aNewReviewTextView.text = @"";
        if (completion)
            completion();
    }
}

@end
