//
//  VenueDetailsInfoCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueDetailsInfoCell.h"
#import "VenueDetailsInfoCellModel.h"
#import <ETRUtils/ETRUtils.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueDetailsInfoCell ()

@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic, strong) IBOutlet UILabel *isOpenLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;

@end

@implementation VenueDetailsInfoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.ratingLabel, text) = RACObserve(self, viewModel.venue.formattedRating);
    RAC(self.ratingLabel, textColor) = [RACObserve(self, viewModel.venue.ratingColor) map:^UIColor *(NSString *value) {
        return [UIColor etr_colorWithHexString:value];
    }];
    RAC(self.isOpenLabel, text) = RACObserve(self, viewModel.venue.isOpenStatus);
    RAC(self.addressLabel, text) = [RACObserve(self, viewModel.venue.formattedAddress) map:^NSString *(NSArray *value) {
        return [value firstObject];
    }];
}

@end
