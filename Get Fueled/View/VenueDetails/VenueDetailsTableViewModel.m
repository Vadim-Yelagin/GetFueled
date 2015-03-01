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
#import <ETRCollectionModel/ETRStaticCellModel.h>

@interface VenueDetailsTableViewModel ()

@property (nonatomic, strong) id addReviewItem;

@end

@implementation VenueDetailsTableViewModel

- (instancetype)initWithVenue:(Venue *)venue
{
    VenueDetailsOverviewCellModel *overview = [[VenueDetailsOverviewCellModel alloc] initWithVenue:venue];

    TextViewCellModel *newReviewTextView = [[TextViewCellModel alloc] init];
    ETRStaticCellModel *addReview = [[ETRStaticCellModel alloc] initWithReuseIdentifier:@"AddReviewCell"];
    
    NSArray *items = @[overview, newReviewTextView, addReview];
    self = [super initWithSections:@[items]];
    if (self) {
        _venue = venue;
        _addReviewItem = addReview;
    }
    return self;
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
                      completion:(void (^)(void))completion
{
    id item = [self itemAtIndexPath:indexPath];
    if (item == self.addReviewItem) {
        if (completion)
            completion();
    }
}

@end
