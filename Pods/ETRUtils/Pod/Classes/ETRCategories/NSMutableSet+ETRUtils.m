//
//  NSMutableSet+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSMutableSet+ETRUtils.h"

@implementation NSMutableSet (ETRUtils)

- (void)etr_safeAdd:(id)object
{
    if (object)
        [self addObject:object];
}

@end
