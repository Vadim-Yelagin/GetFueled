//
//  SplitViewController.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "SplitViewController.h"
#import "VenueDetailsTableViewController.h"
#import "VenueDetailsTableViewModel.h"
#import "VenuesTableViewController.h"
#import "VenuesTableViewControllerDelegate.h"

@interface SplitViewController () <VenuesTableViewControllerDelegate>

@property (nonatomic, strong) VenuesTableViewController *venuesVC;
@property (nonatomic, strong) VenueDetailsTableViewController *detailsVC;

@end

@implementation SplitViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbedVenues"]) {
        UINavigationController *nc = segue.destinationViewController;
        self.venuesVC = nc.viewControllers.firstObject;
        self.venuesVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EmbedDetails"]) {
        UINavigationController *nc = segue.destinationViewController;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"VenueDetailsTableViewController" bundle:nil];
        self.detailsVC = [sb instantiateInitialViewController];
        self.detailsVC.viewModel = [[VenueDetailsTableViewModel alloc] initWithVenue:nil];
        nc.viewControllers = @[self.detailsVC];
    }
}

- (void)venuesTableViewController:(VenuesTableViewController *)viewController
                   didSelectVenue:(Venue *)venue
{
    self.detailsVC.viewModel = [[VenueDetailsTableViewModel alloc] initWithVenue:venue];
}

@end
