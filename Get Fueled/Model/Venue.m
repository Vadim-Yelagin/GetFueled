//
//  Venue.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueCategory.h"
#import <ETRUtils/ETRUtils.h>

@implementation Venue

@dynamic identifier;
@dynamic name;
@dynamic siteURL;
@dynamic reservationsURL;
@dynamic menuURL;
@dynamic actual;
@dynamic isOpen;
@dynamic isOpenStatus;
@dynamic distance;
@dynamic latitude;
@dynamic longitude;
@dynamic rating;
@dynamic ratingColor;
@dynamic thumbsDown;
@dynamic formattedAddress;
@dynamic reviews;
@dynamic categories;
@dynamic photosGroups;

- (NSArray *)sortedCategories
{
    return [self.categories sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}

- (NSString *)categoryNames
{
    NSArray *sortedNames = [[self sortedCategories] etr_map:^NSString *(VenueCategory *obj) { return obj.name; }];
    return [sortedNames componentsJoinedByString:@", "];
}

- (VenueCategory *)firstCategory
{
    return [self sortedCategories].firstObject;
}

- (NSString *)formattedRating
{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.usesSignificantDigits = YES;
    nf.minimumSignificantDigits = 2;
    nf.maximumSignificantDigits = 2;
    return [nf stringFromNumber:@(self.rating)];
}

+ (NSSet *)keyPathsForValuesAffectingFormattedRating
{
    return [NSSet setWithObject:@"rating"];
}

@end
