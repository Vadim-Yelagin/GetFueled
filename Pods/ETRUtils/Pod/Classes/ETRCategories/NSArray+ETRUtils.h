//
//  NSArray+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSArray (ETRUtils)

- (NSInteger)etr_minimumUsingComparator:(NSComparator)cmptr;
- (NSArray *)etr_map:(id(^)(id obj))block;
- (NSArray *)etr_filter:(BOOL(^)(id obj))block;
- (NSArray *)etr_flatMap:(NSArray *(^)(id obj))block;
- (NSArray *)etr_flatten;
- (NSArray *)etr_take:(NSInteger)count;
- (NSDictionary *)etr_collateBy:(id<NSCopying>(^)(id obj))block;
- (NSDictionary *)etr_collateByKeyPath:(NSString *)keyPath;

@end
