//
//  VenueDetailsOverviewCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Venue.h"
#import "VenueCategory.h"
#import "VenueDetailsOverviewCell.h"
#import "VenueDetailsOverviewCellModel.h"
#import <ETRUtils/ETRUtils.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RestKit/RestKit.h>

@interface VenueDetailsOverviewCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *photoView;
@property (nonatomic, strong) IBOutlet UILabel *categoriesLabel;
@property (nonatomic, strong) IBOutlet UIImageView *categoryIcon;

@end

@implementation VenueDetailsOverviewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    RAC(self.nameLabel, text) = RACObserve(self, viewModel.name);
    RAC(self.categoriesLabel, text) = RACObserve(self, viewModel.categories);
    
    RACSignal *photoURLs = RACObserve(self, viewModel.photoURL);
    RACSignal *placeholderPhoto = [RACSignal return:[UIImage etr_imageWithColor:[UIColor grayColor] size:CGSizeMake(1, 1)]];
    [self.photoView rac_liftSelector:@selector(setImageWithURL:placeholderImage:) withSignals:photoURLs, placeholderPhoto, nil];
    
    RACSignal *categoryIconURLs = RACObserve(self, viewModel.categoryIconURL);
    RACSignal *placeholderIcon = [RACSignal return:[UIImage etr_imageWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)]];
    [self.categoryIcon rac_liftSelector:@selector(setImageWithURL:placeholderImage:) withSignals:categoryIconURLs, placeholderIcon, nil];
}

@end
