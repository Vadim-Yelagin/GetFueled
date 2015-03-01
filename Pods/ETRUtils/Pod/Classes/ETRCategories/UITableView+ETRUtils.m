//
//  UITableView+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UITableView+ETRUtils.h"

@implementation UITableView (ETRUtils)

- (void)etr_deselectAllRowsAnimated:(BOOL)animated
{
    NSArray* sel = self.indexPathsForSelectedRows;
    for (NSIndexPath* ip in sel) {
        [self deselectRowAtIndexPath:ip animated:animated];
    }
}

- (void)etr_reloadDataKeepingSelection
{
    NSArray* paths = self.indexPathsForSelectedRows;
    [self reloadData];
    for (NSIndexPath* path in paths) {
        if (path.section < self.numberOfSections &&
            path.row < [self numberOfRowsInSection:path.section])
        {
            [self selectRowAtIndexPath:path
                              animated:NO
                        scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

@end
