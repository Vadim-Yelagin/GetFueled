//
//  NSMutableDictionary+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSMutableDictionary (ETRUtils)

- (void)etr_safeSetObject:(id)object
                   forKey:(id<NSCopying>)key;

@end
