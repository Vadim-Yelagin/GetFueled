//
//  VenuesTableViewController.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewController.h"
#import "VenuesTableViewModel.h"

@protocol VenuesTableViewControllerDelegate;

@interface VenuesTableViewController : ETRTableViewController

@property (nonatomic, weak) IBOutlet id<VenuesTableViewControllerDelegate> delegate;
@property (nonatomic, strong) VenuesTableViewModel *viewModel;

@end
