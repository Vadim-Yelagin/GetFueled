//
//  UIColor+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UIColor+ETRUtils.h"

#define ETRFloatColor(x) ((x & 0xFF) / 255.0f)

@implementation UIColor (ETRUtils)

+ (UIColor *)etr_colorWithHex:(uint32_t)hex
{
    CGFloat red = ETRFloatColor(hex >> 16);
    CGFloat green = ETRFloatColor(hex >> 8);
    CGFloat blue = ETRFloatColor(hex);
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)etr_colorWithHexString:(NSString *)hex
{
    if (!hex)
        return nil;
    uint32_t hexColor = 0;
    NSScanner* scanner = [NSScanner scannerWithString:hex];
    [scanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]
                        intoString:nil];
    [scanner scanHexInt:&hexColor];
    return [UIColor etr_colorWithHex:hexColor];
}

@end
