//
//  UIRefreshControl+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UIRefreshControl+ETRUtils.h"

@implementation UIRefreshControl (ETRUtils)

- (void)setRefreshing:(BOOL)refreshing
{
    if (refreshing) {
        [self beginRefreshing];
    } else {
        [self endRefreshing];
    }
}

@end
