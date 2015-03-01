//
//  NSString+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSArray+ETRUtils.h"
#import "NSString+ETRUtils.h"

@implementation NSString (ETRUtils)

- (NSInteger)etr_numberOfWords
{
    __block NSInteger count = 0;
    NSStringEnumerationOptions opts = NSStringEnumerationByWords
    | NSStringEnumerationSubstringNotRequired
    | NSStringEnumerationLocalized;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:opts
                          usingBlock:^(NSString *substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL *stop) {
                              ++count;
                          }];
    return count;
}

- (NSString *)etr_stringBySafeAppend:(NSString *)string
{
    return string ? [self stringByAppendingString:string] : self;
}

- (NSDecimalNumber *)etr_decimalNumberValue
{
    static NSNumberFormatter* nf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nf = [NSNumberFormatter new];
        nf.numberStyle = NSNumberFormatterDecimalStyle;
        nf.locale = [NSLocale autoupdatingCurrentLocale];
        nf.generatesDecimalNumbers = YES;
    });
    return (NSDecimalNumber*)[nf numberFromString:self];
}

- (NSString *)etr_stringByRemovingNonBMPCharacters
{
    NSCharacterSet *bmp = [NSCharacterSet characterSetWithRange:NSMakeRange(0, 0xFFFF)];
    NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *comps = [self componentsSeparatedByCharactersInSet:[bmp invertedSet]];
    NSArray *trim = [comps etr_map:^NSString *(NSString *obj) {
        NSString *res = [obj stringByTrimmingCharactersInSet:ws];
        return res.length ? res : nil;
    }];
    return [trim componentsJoinedByString:@" "];
}

@end
