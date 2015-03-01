//
//  VenueDetailsTableViewController.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewController.h"
#import "VenueDetailsTableViewModel.h"

@interface VenueDetailsTableViewController : ETRTableViewController

@property (nonatomic, strong) VenueDetailsTableViewModel *viewModel;

@end
