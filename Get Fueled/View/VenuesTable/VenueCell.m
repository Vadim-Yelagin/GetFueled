//
//  VenueCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueCell.h"
#import <ETRUtils/ETRUtils.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic, strong) IBOutlet UILabel *isOpenLabel;

@end

@implementation VenueCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.nameLabel, text) = RACObserve(self, viewModel.name);
    RAC(self.ratingLabel, text) = [RACObserve(self, viewModel.rating) map:^NSString *(NSNumber *value) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        nf.numberStyle = NSNumberFormatterDecimalStyle;
        nf.minimumSignificantDigits = 2;
        nf.maximumSignificantDigits = 2;
        return [nf stringFromNumber:value];
    }];
    RAC(self.ratingLabel, textColor) = [RACObserve(self, viewModel.ratingColor) map:^UIColor *(NSString *value) {
        return [UIColor etr_colorWithHexString:value];
    }];
    RAC(self.isOpenLabel, text) = RACObserve(self, viewModel.isOpenStatus);
    RAC(self.isOpenLabel, textColor) = [RACObserve(self, viewModel.isOpen) map:^UIColor *(NSNumber *value) {
        return value.boolValue ? [UIColor blackColor] : [UIColor redColor];
    }];
}

+ (NSString *)reuseIdentifier
{
    return @"VenueCell";
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"VenueCell"
                          bundle:nil];
}

+ (CGFloat)heightForViewModel:(Venue *)viewModel
                  inTableView:(UITableView *)tableView
{
    static VenueCell *prototype = nil;
    if (!prototype) {
        prototype = [[self nib] instantiateWithOwner:nil options:nil].firstObject;
    }
    UILabel *label = prototype.nameLabel;
    label.text = viewModel.name;
    CGFloat xPadding = prototype.bounds.size.width - label.bounds.size.width;
    CGFloat yPadding = prototype.bounds.size.height - label.bounds.size.height;
    CGFloat labelWidth = tableView.bounds.size.width - xPadding;
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(labelWidth, 9999)].height;
    return labelHeight + yPadding;
}

@end
