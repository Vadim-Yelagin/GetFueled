//
//  VenuesTableViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueCell.h"
#import "VenueDetailsTableViewController.h"
#import "VenueDetailsTableViewModel.h"
#import "VenuesTableViewController.h"
#import <ETRUtils/ETRUtils.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation VenuesTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.reuseIdentifierMatching.defaultReuseIdentifier = @"VenueCell";
    self.viewModel = [[VenuesTableViewModel alloc] init];
    RACCommand *refreshCommand = self.viewModel.refreshCommand;
    [self rac_liftSelector:@selector(etr_alertError:)
               withSignals:refreshCommand.errors, nil];
    [refreshCommand execute:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl.rac_command = self.viewModel.refreshCommand;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VenueDetailsSegue"]) {
        VenueCell *cell = sender;
        VenueDetailsTableViewController *vc = segue.destinationViewController;
        vc.viewModel = [[VenueDetailsTableViewModel alloc] initWithVenue:cell.viewModel];
    }
}

- (CGFloat)rowHeightForItem:(id)item
{
    return ETRDynamicRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.rowHeight;
}

@end
