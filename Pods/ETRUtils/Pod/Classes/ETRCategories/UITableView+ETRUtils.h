//
//  UITableView+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface UITableView (ETRUtils)

- (void)etr_deselectAllRowsAnimated:(BOOL)animated;
- (void)etr_reloadDataKeepingSelection;

@end
