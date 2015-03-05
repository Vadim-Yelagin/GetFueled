//
//  VenueDetailsOverviewCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareService.h"
#import "Venue.h"
#import "VenueCategory.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenuePhotosGroup.h"
#import "VenuePhoto.h"

@interface VenueDetailsOverviewCellModel ()

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *categories;
@property (nonatomic, readwrite, strong) NSURL *photoURL;
@property (nonatomic, readwrite, strong) NSURL *categoryIconURL;

@end

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
        [self updateViews];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(updateViews)
                   name:NSManagedObjectContextDidSaveNotification
                 object:[FoursquareService sharedService].mainMOC];
    }
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self
                  name:NSManagedObjectContextDidSaveNotification
                object:[FoursquareService sharedService].mainMOC];
}

- (void)updateViews
{
    if (!self.venue)
        return;
    self.name = self.venue.name;
    self.categories = [self.venue categoryNames];
    self.categoryIconURL = [self.venue firstCategory].whiteIconURL;
    VenuePhotosGroup *photoGroup = self.venue.photosGroups.anyObject;
    VenuePhoto *photo = photoGroup.items.anyObject;
    if (!photo) {
        self.photoURL = nil;
        return;
    }
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat ratio = [[self class] photoRatio];
    CGFloat screenSide = MIN(screen.bounds.size.width, screen.bounds.size.height);
    CGFloat width = screenSide * screen.scale;
    CGFloat height = width * ratio;
    CGFloat parallax = 20 * screen.scale;
    width += parallax;
    height += parallax;
    NSString *size = [NSString stringWithFormat:@"%dx%d", (int)width, (int)height];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", photo.prefix, size, photo.suffix];
    self.photoURL = [NSURL URLWithString:urlString];
}

@end
