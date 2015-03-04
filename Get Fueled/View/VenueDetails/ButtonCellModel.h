//
//  ButtonCellModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 04/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonCellModel : NSObject

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^action)(void);

@end
