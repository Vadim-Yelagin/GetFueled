//
//  VenueDetailsTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueDetailsTableViewController.h"

@implementation VenueDetailsTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.reuseIdentifierMatching.defaultReuseIdentifier = @"ReviewCell";
}

- (CGFloat)rowHeightForItem:(id)item
{
    return ETRDynamicRowHeight;
}

@end
