//
//  UITableViewCell+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UITableViewCell+ETRUtils.h"

@implementation UITableViewCell (ETRUtils)

- (void)setSelectionColor:(UIColor *)selectionColor
{
    UIView* bg = [[UIView alloc] init];
    bg.backgroundColor = selectionColor;
    self.selectedBackgroundView = bg;
}

- (UIColor *)selectionColor
{
    return self.selectedBackgroundView.backgroundColor;
}

- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor
{
    UIView* bg = [[UIView alloc] init];
    bg.backgroundColor = backgroundViewColor;
    self.backgroundView = bg;
}

- (UIColor *)backgroundViewColor
{
    return self.backgroundView.backgroundColor;
}

@end
