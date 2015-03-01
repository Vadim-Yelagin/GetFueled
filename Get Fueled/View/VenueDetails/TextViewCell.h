//
//  TextViewCell.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewCell.h"

@class TextViewCellModel;

@interface TextViewCell : ETRTableViewCell

@property (nonatomic, strong) TextViewCellModel *viewModel;

@end
