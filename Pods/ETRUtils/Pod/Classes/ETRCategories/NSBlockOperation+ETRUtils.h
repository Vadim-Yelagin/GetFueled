//
//  NSBlockOperation+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSBlockOperation (ETRUtils)

+ (id)etr_blockOperationWithBlock2:(void (^)(NSBlockOperation* operation))block;

@end
