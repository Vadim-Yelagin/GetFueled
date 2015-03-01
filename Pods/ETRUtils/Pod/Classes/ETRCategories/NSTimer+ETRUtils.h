//
//  NSTimer+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSTimer (ETRUtils)

- (instancetype)initWithFireDate:(NSDate *)date
              interval:(NSTimeInterval)interval
                 block:(void(^)(NSTimer *timer))block
               repeats:(BOOL)repeats;

@end
