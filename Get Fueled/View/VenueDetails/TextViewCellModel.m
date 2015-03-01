//
//  TextViewCellModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "TextViewCellModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TextViewCellModel ()

@property (nonatomic, readonly, strong) RACSubject *endEditingSubject;

@end

@implementation TextViewCellModel

@synthesize endEditingSubject = _endEditingSubject;

- (NSString *)reuseIdentifier
{
    return @"TextViewCell";
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    NSLog(@"SET %@", text);
}

- (RACSignal *)endEditingSignal
{
    return self.endEditingSubject;
}
- (RACSubject *)endEditingSubject
{
    if (!_endEditingSubject) {
        _endEditingSubject = [RACSubject subject];
    }
    return _endEditingSubject;
}

- (void)endEditing
{
    [self.endEditingSubject sendNext:@YES];
}

@end
