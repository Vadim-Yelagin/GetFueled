//
//  TextViewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TextViewCell.h"
#import "TextViewCellModel.h"
#import <ETRCollectionModel/ETRTableViewController.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TextViewCell () <UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *textViewHeight;

@end

@implementation TextViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RACSignal *modelText = RACObserve(self, viewModel.text);
    [self rac_liftSelector:@selector(setText:)
               withSignals:modelText, nil];
}

- (void)setText:(NSString *)text
{
    if ([text isEqual:self.textView.text])
        return;
    self.textView.text = text;
    [self updateHeight];
}

- (void)updateHeight
{
    [self.textView layoutSubviews];
    CGFloat newHeight = self.textView.contentSize.height + 30;
    if (self.textViewHeight.constant == newHeight)
        return;
    self.textViewHeight.constant = newHeight;
    UITableView *tableView = self.tableViewController.tableView;
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.viewModel.text = textView.text;
    [self updateHeight];
}

@end
