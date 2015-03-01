//
//  ETRStringDecorator.h
//
//  Created by Vadim Yelagin on 17/06/14.
//  Copyright (c) 2014 EastBanc Technologies. All rights reserved.
//

@import UIKit;

@interface ETRStringDecorator : NSObject <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, copy) NSArray* formats;
@property (nonatomic, copy) NSString* dataCharacters;
@property (nonatomic, copy) NSString* placeholderCharacter;

- (instancetype)initWithFormats:(NSArray *)formats NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDateStringTemplate:(NSString *)stringTemplate;

- (NSString*)decorateString:(NSString*)dataString;
- (NSString*)distillString:(NSString*)decoratedString;
- (NSRange)convertRange:(NSRange)range
    fromDecoratedString:(NSString*)decoratedString;

@end
