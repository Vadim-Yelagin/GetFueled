//
//  VenueDetailsInfoCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueDetailsInfoCellModel.h"

@implementation VenueDetailsInfoCellModel

- (NSString *)reuseIdentifier
{
    return @"VenueDetailsInfoCell";
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
