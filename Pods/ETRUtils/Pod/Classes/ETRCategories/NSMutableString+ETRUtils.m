//
//  NSMutableString+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSMutableString+ETRUtils.h"

@implementation NSMutableString (ETRUtils)

- (void)etr_safeAppend:(NSString *)string
{
    if (string)
        [self appendString:string];
}

@end
