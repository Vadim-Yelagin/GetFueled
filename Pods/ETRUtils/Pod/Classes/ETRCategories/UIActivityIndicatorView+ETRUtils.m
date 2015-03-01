//
//  UIActivityIndicatorView+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UIActivityIndicatorView+ETRUtils.h"

@implementation UIActivityIndicatorView (ETRUtils)

- (void)setAnimating:(BOOL)animating
{
    if (animating) {
        [self startAnimating];
    } else {
        [self stopAnimating];
    }
}

@end
