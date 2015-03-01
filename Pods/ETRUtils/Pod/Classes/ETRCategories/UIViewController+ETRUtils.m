//
//  UIViewController+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSError+ETRUtils.h"
#import "UIViewController+ETRUtils.h"

@implementation UIViewController (ETRUtils)

- (void)etr_alertError:(NSError*)error
{
    if (!self.isViewLoaded || !self.view.window || error.etr_isCancelledError)
        return;
    [[[UIAlertView alloc] initWithTitle:error.etr_description
                                message:error.localizedRecoverySuggestion
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
