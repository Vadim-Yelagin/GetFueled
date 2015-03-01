//
//  ETRRACAdditions.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRRACAdditions.h"

@implementation RACSignal (ETROperations)

- (RACSignal *)formatWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    return [RACSignal combineLatest:@[self,
                                      [NSTimeZone rac_systemTimeZone],
                                      [NSLocale rac_currentLocale]]
                             reduce:^(NSDate* date, id value1, id value2) {
                                 return date ? [dateFormatter stringFromDate:date] : nil;
                             }];
}

@end

@implementation NSLocale (RACSupport)

+ (RACSignal *)rac_currentLocale
{
    static RACSignal *currentLocale = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentLocale = [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSCurrentLocaleDidChangeNotification object:nil] startWith:nil] map:^NSLocale*(NSNotification* notification) { return [NSLocale currentLocale]; }];
    });
    return currentLocale;
}

@end

@implementation NSTimeZone (RACSupport)

+ (RACSignal *)rac_systemTimeZone
{
    static RACSignal *systemTimeZone = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemTimeZone = [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSSystemTimeZoneDidChangeNotification object:nil] startWith:nil] map:^NSTimeZone*(NSNotification* notification) { return [NSTimeZone systemTimeZone]; }];
    });
    return systemTimeZone;
}

@end
