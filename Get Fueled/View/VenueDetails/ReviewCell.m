//
//  ReviewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRRACAdditions.h"
#import "Review.h"
#import "ReviewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ReviewCell ()

@property (nonatomic, strong) IBOutlet UILabel *reviewTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateCreatedLabel;

@end

@implementation ReviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.reviewTextLabel, text) = RACObserve(self, viewModel.text);
    
    static NSDateFormatter *df = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        df.timeStyle = NSDateFormatterShortStyle;
        df.dateStyle = NSDateFormatterMediumStyle;
        df.doesRelativeDateFormatting = YES;
    });
    RAC(self.dateCreatedLabel, text) = [RACObserve(self, viewModel.dateCreated) formatWithDateFormatter:df];
}

@end
