//
//  ReviewCell.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewCell.h"

@class Review;

@interface ReviewCell : ETRTableViewCell

@property (nonatomic, strong) Review *viewModel;

@end
