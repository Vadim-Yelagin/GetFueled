//
//  VenueCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VenueCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation VenueCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.nameLabel, text) = RACObserve(self, viewModel.name);
}

@end
