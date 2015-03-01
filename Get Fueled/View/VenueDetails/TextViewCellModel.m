//
//  TextViewCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TextViewCellModel.h"

@implementation TextViewCellModel

- (NSString *)reuseIdentifier
{
    return @"TextViewCell";
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    NSLog(@"SET %@", text);
}

@end
