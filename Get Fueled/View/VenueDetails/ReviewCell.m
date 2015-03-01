//
//  ReviewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Review.h"
#import "ReviewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ReviewCell ()

@property (nonatomic, strong) IBOutlet UILabel *reviewTextLabel;

@end

@implementation ReviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.reviewTextLabel, text) = RACObserve(self, viewModel.text);
}

@end
