//
//  VenueCategory.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueCategory.h"
#import "Venue.h"


@implementation VenueCategory

@dynamic identifier;
@dynamic name;
@dynamic iconPrefix;
@dynamic iconSuffix;
@dynamic venues;

- (NSURL *)iconURL
{
    if (!self.iconPrefix || !self.iconSuffix)
        return nil;
    NSString *urlString = [NSString stringWithFormat:@"%@bg_32%@", self.iconPrefix, self.iconSuffix];
    return [NSURL URLWithString:urlString];
}

+ (NSSet *)keyPathsForValuesAffectingIconURL
{
    return [NSSet setWithObjects:@"iconPrefix", @"iconSuffix", nil];
}

@end
