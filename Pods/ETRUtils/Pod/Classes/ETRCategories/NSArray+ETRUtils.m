//
//  NSArray+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSArray+ETRUtils.h"

@implementation NSArray (ETRUtils)

- (NSInteger)etr_minimumUsingComparator:(NSComparator)cmptr
{
    NSInteger idx = 0;
    NSInteger minIdx = NSNotFound;
    id minObj = nil;
    for (id obj in self) {
        if (minIdx == NSNotFound || cmptr(minObj, obj) == NSOrderedDescending) {
            minIdx = idx;
            minObj = obj;
        }
        idx++;
    }
    return minIdx;
}

- (NSArray *)etr_map:(id (^)(id obj))block
{
    if (!block)
        return @[];
    NSMutableArray* res = [NSMutableArray array];
    for (id obj in self) {
        id mapped = block(obj);
        if (mapped)
            [res addObject:mapped];
    }
    return res;
}

- (NSArray *)etr_filter:(BOOL (^)(id))block
{
    if (!block)
        return @[];
    return [self etr_map:^id(id obj) {
        return block(obj) ? obj : nil;
    }];
}

- (NSArray *)etr_flatMap:(NSArray *(^)(id obj))block
{
    if (!block)
        return @[];
    NSMutableArray* res = [NSMutableArray array];
    for (id obj in self) {
        NSArray *mapped = block(obj);
        if (mapped)
            [res addObjectsFromArray:mapped];
    }
    return res;
}

- (NSArray *)etr_flatten
{
    return [self etr_flatMap:^NSArray *(id obj) {
        return obj;
    }];
}

- (NSArray *)etr_take:(NSInteger)count
{
    if (count >= self.count)
        return self;
    if (count <= 0)
        return @[];
    return [self subarrayWithRange:NSMakeRange(0, count)];
}

- (NSDictionary *)etr_collateBy:(id<NSCopying> (^)(id))block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id obj in self) {
        id<NSCopying> key = block(obj);
        if (!key)
            continue;
        NSMutableArray *group = dict[key];
        if (group) {
            [group addObject:obj];
        } else {
            dict[key] = [NSMutableArray arrayWithObject:obj];
        }
    }
    return dict;
}

- (NSDictionary *)etr_collateByKeyPath:(NSString *)keyPath
{
    return [self etr_collateBy:^id<NSCopying>(id obj) {
        return [obj valueForKeyPath:keyPath];
    }];
}

@end
