//
//  TextViewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TextViewCell.h"
#import "TextViewCellModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TextViewCell ()

@property (nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation TextViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.textView, text) = RACObserve(self, viewModel.text);
    RAC(self, viewModel.text) = [self.textView.rac_textSignal skip:1];
}

@end
