//
//  NSMutableDictionary+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSMutableDictionary+ETRUtils.h"

@implementation NSMutableDictionary (ETRUtils)

- (void)etr_safeSetObject:(id)object
                   forKey:(id<NSCopying>)key
{
    if (key) {
        if (object) {
            self[key] = object;
        } else {
            [self removeObjectForKey:key];
        }
    }
}

@end
