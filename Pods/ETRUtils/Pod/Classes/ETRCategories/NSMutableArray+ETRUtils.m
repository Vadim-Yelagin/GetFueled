//
//  NSMutableArray+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSMutableArray+ETRUtils.h"

@implementation NSMutableArray (ETRUtils)

- (void)etr_safeAdd:(id)object
{
    if (object)
        [self addObject:object];
}

@end
