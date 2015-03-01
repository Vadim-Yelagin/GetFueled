//
//  FoursquareService.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface FoursquareService : NSObject

+ (instancetype)sharedService;

- (RACSignal *)exploreWithLatitude:(double)latitude
                         longitude:(double)longitude
                           section:(NSString *)section
                             limit:(NSInteger)limit;

@end
