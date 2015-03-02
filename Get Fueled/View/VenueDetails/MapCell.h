//
//  MapCell.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRTableViewCell.h"

@class MapCellModel;

@interface MapCell : ETRTableViewCell

@property (nonatomic, strong) MapCellModel *viewModel;

@end
