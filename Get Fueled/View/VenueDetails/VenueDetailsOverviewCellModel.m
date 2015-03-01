//
//  VenueDetailsOverviewCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueDetailsOverviewCellModel.h"

@implementation VenueDetailsOverviewCellModel

- (NSString *)reuseIdentifier
{
    return @"VenueDetailsOverviewCell";
}

- (instancetype)initWithVenue:(Venue *)venue
{
    self = [super init];
    if (self) {
        _venue = venue;
    }
    return self;
}

@end
