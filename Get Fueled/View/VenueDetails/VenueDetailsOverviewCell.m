//
//  VenueDetailsOverviewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueDetailsOverviewCell.h"
#import "VenueDetailsOverviewCellModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueDetailsOverviewCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation VenueDetailsOverviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.nameLabel, text) = RACObserve(self, viewModel.venue.name);
}

@end
