//
//  VenueDetailsTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ButtonCellModel.h"
#import "MapCellModel.h"
#import "VenueDetailsOverviewCellModel.h"
#import "VenueDetailsTableViewController.h"

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
    if ([item isKindOfClass:[ButtonCellModel class]]) {
        return 44;
    }
    if (item == self.viewModel.noContentItem) {
        return self.tableView.bounds.size.height - self.tableView.scrollIndicatorInsets.top;
    }
    return ETRDynamicRowHeight;
}

@end
