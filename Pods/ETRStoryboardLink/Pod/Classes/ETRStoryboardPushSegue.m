//
//  ETRStoryboardPushSegue.m
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRStoryboardPushSegue.h"

@implementation ETRStoryboardPushSegue

- (void)perform
{
    UIViewController* source = self.sourceViewController;
    UINavigationController* navController = nil;
    if ([source isKindOfClass:[UINavigationController class]]) {
        navController = (UINavigationController*)source;
    } else {
        navController = source.navigationController;
    }
    [navController pushViewController:self.destinationViewController
                             animated:self.animated];
}

@end
