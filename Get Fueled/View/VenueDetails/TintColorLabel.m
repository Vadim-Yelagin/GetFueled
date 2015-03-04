//
//  TintColorLabel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TintColorLabel.h"

@implementation TintColorLabel

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.textColor = self.tintColor;
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    self.textColor = self.tintColor;
}

@end
