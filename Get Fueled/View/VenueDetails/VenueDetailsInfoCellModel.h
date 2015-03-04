//
//  VenueDetailsInfoCellModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Venue;

@interface VenueDetailsInfoCellModel : NSObject

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (nonatomic, readonly, strong) Venue *venue;

- (instancetype)initWithVenue:(Venue *)venue;

@end
