//
//  TextViewCellModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextViewCellModel : NSObject

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

@end
