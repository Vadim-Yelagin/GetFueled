//
//  VenueDetailsTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

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
    if ([item isKindOfClass:[VenueDetailsOverviewCellModel class]]) {
        return self.tableView.bounds.size.width * [VenueDetailsOverviewCellModel photoRatio];
    }
    return ETRDynamicRowHeight;
}

@end
