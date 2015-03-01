//
//  VenueDetailsTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewModel.h"

@implementation VenueDetailsTableViewModel

- (instancetype)initWithVenue:(Venue *)venue
{
    VenueDetailsOverviewCellModel *overview = [[VenueDetailsOverviewCellModel alloc] initWithVenue:venue];
    NSArray *items = @[overview];
    self = [super initWithSections:@[items]];
    if (self) {
        _venue = venue;
    }
    return self;
}

@end
