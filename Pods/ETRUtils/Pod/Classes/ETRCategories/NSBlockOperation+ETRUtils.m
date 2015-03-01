//
//  NSBlockOperation+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSBlockOperation+ETRUtils.h"

@implementation NSBlockOperation (ETRUtils)

+ (id)etr_blockOperationWithBlock2:(void (^)(NSBlockOperation* operation))block
{
    NSBlockOperation* op = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation* weakOp = op;
    [op addExecutionBlock:^{
        NSBlockOperation* strongOp = weakOp;
        if (strongOp && block && !strongOp.isCancelled) {
            block(strongOp);
        }
    }];
    return op;
}

@end
