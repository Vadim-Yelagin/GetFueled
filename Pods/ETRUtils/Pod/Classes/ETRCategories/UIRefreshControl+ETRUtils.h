//
//  UIRefreshControl+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface UIRefreshControl (ETRUtils)

@property (nonatomic, readwrite, getter = isRefreshing) BOOL refreshing;

@end
