//
//  NSTimer+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSTimer+ETRUtils.h"
#import <objc/runtime.h>

@interface ETRTimerTarget : NSObject

@property (nonatomic, copy) void(^block)(NSTimer *timer);

- (void)fire:(NSTimer*)timer;

@end

@implementation ETRTimerTarget

- (void)fire:(NSTimer *)timer
{
    if (self.block)
        self.block(timer);
}

@end

static void * ETRUtilsNSTimerTarger = &ETRUtilsNSTimerTarger;

@implementation NSTimer (ETRUtils)

- (instancetype)initWithFireDate:(NSDate *)date
              interval:(NSTimeInterval)interval
                 block:(void (^)(NSTimer *))block
               repeats:(BOOL)repeats
{
    ETRTimerTarget* target = [[ETRTimerTarget alloc] init];
    target.block = block;
    self = [self initWithFireDate:date
                         interval:interval
                           target:target
                         selector:@selector(fire:)
                         userInfo:nil
                          repeats:repeats];
    if (self) {
        objc_setAssociatedObject(self,
                                 ETRUtilsNSTimerTarger,
                                 target,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

@end
