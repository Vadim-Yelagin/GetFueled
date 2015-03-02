//
//  MapCellModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapCellModel : NSObject

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
