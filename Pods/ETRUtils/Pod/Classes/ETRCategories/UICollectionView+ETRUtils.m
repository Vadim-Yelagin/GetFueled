//
//  UICollectionView+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UICollectionView+ETRUtils.h"

@implementation UICollectionView (ETRUtils)

- (void)etr_deselectAllItemsAnimated:(BOOL)animated
{
    NSArray* sel = self.indexPathsForSelectedItems;
    for (NSIndexPath* ip in sel) {
        [self deselectItemAtIndexPath:ip animated:YES];
    }
}

@end
