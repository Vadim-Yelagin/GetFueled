//
//  VenuesTableViewController.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewController.h"
#import "VenuesTableViewModel.h"

@interface VenuesTableViewController : ETRTableViewController

@property (nonatomic, strong) VenuesTableViewModel *viewModel;

@end
