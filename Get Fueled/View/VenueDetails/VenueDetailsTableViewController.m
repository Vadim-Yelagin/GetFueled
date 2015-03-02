//
//  VenueDetailsTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "MapCellModel.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewController.h"
#import <ETRCollectionModel/ETRStaticCellModel.h>

@implementation VenueDetailsTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.reuseIdentifierMatching.defaultReuseIdentifier = @"ReviewCell";
}

- (CGFloat)rowHeightForItem:(id)item
{
    if ([item isKindOfClass:[VenueDetailsOverviewCellModel class]] ||
        [item isKindOfClass:[MapCellModel class]])
    {
        CGFloat height = self.tableView.bounds.size.width * [VenueDetailsOverviewCellModel photoRatio];
        return MIN(height, round(self.tableView.bounds.size.height / 2));
    }
    if ([item isKindOfClass:[ETRStaticCellModel class]]) {
        return 44;
    }
    return ETRDynamicRowHeight;
}

@end
