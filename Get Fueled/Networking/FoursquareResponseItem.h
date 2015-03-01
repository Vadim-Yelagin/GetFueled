//
//  FoursquareResponseItem.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Venue;

@interface FoursquareResponseItem : NSObject

@property (nonatomic, strong) Venue *venue;

@end
