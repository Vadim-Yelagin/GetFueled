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

@property (nonatomic, strong) IBOutlet UILabel *placeholderLabel;
@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *textViewHeight;

@end

@implementation TextViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.placeholderLabel, text) = RACObserve(self, viewModel.placeholder);
    RACSignal *modelText = RACObserve(self, viewModel.text);
    [self rac_liftSelector:@selector(setText:)
               withSignals:modelText, nil];
    RACSignal *endEditing = [RACObserve(self, viewModel.endEditingSignal) switchToLatest];
    [self rac_liftSelector:@selector(endTextViewEditing:)
               withSignals:endEditing, nil];
}

- (void)endTextViewEditing:(id)dummy
{
    [self.textView resignFirstResponder];
}

- (void)setText:(NSString *)text
{
    self.placeholderLabel.hidden = (text.length > 0);
    if ([text isEqual:self.textView.text])
        return;
    self.textView.text = text;
    [self updateHeight];
}

- (void)updateHeight
{
    [self.textView layoutSubviews];
    CGFloat newHeight = self.textView.contentSize.height + 20;
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
