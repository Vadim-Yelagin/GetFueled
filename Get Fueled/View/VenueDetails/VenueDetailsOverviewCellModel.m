//
//  VenueDetailsOverviewCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenuePhotosGroup.h"
#import "VenuePhoto.h"

@implementation VenueDetailsOverviewCellModel

- (NSString *)reuseIdentifier
{
    return @"VenueDetailsOverviewCell";
}

+ (CGFloat)photoRatio
{
    return 0.618034;
}

- (instancetype)initWithVenue:(Venue *)venue
{
    self = [super init];
    if (self) {
        _venue = venue;
        VenuePhotosGroup *photoGroup = venue.photosGroups.anyObject;
        VenuePhoto *photo = photoGroup.items.anyObject;
        if (photo) {
            UIScreen *screen = [UIScreen mainScreen];
            CGFloat ratio = [[self class] photoRatio];
            int width = round(screen.bounds.size.width * screen.scale);
            int height = round(width * ratio);
            NSString *size = [NSString stringWithFormat:@"%dx%d", width, height];
            NSString *urlString = [NSString stringWithFormat:@"%@%@%@", photo.prefix, size, photo.suffix];
            _photoURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

@end
