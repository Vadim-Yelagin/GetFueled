//
//  VenueDetailsPush.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "VenueDetailsPush.h"
#import "VenuesTableViewController.h"

@implementation VenueDetailsPush

- (void)venuesTableViewController:(VenuesTableViewController *)viewController
                   didSelectVenue:(id)venue
{
    [viewController performSegueWithIdentifier:@"VenueDetailsSegue"
                                        sender:venue];
}

@end
