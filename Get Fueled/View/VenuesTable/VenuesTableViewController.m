//
//  VenuesTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenuesTableViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation VenuesTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.reuseIdentifierMatching.defaultReuseIdentifier = @"VenueCell";
    self.viewModel = [[VenuesTableViewModel alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl.rac_command = self.viewModel.refreshCommand;
}

@end
