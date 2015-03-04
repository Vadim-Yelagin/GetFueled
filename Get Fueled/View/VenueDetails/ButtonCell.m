//
//  ButtonCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ButtonCell.h"
#import "ButtonCellModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ButtonCell ()

@property (nonatomic, strong) IBOutlet UILabel *buttonLabel;

@end

@implementation ButtonCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.buttonLabel, text) = RACObserve(self, viewModel.title);
}

@end
