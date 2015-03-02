//
//  VenueDetailsOverviewCellModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Venue;

@interface VenueDetailsOverviewCellModel : NSObject

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (nonatomic, readonly, strong) Venue *venue;
@property (nonatomic, readonly, strong) NSURL *photoURL;

- (instancetype)initWithVenue:(Venue *)venue;
+ (CGFloat)photoRatio;

@end
