//
//  VenuesTableViewControllerDelegate.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Venue;
@class VenuesTableViewController;

@protocol VenuesTableViewControllerDelegate <NSObject>

- (void)venuesTableViewController:(VenuesTableViewController *)viewController
                   didSelectVenue:(Venue *)venue;

@end
