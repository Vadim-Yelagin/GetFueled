//
//  NSNumber+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSNumber+ETRUtils.h"

@implementation NSNumber (ETRUtils)

- (NSString *)etr_localizedDecimalString
{
    static NSNumberFormatter* nf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nf = [NSNumberFormatter new];
        nf.numberStyle = NSNumberFormatterDecimalStyle;
        nf.locale = [NSLocale autoupdatingCurrentLocale];
    });
    return [nf stringFromNumber:self];
}

@end
