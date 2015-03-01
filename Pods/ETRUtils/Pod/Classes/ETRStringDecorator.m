//
//  ETRStringDecorator.m
//
//  Created by Vadim Yelagin on 17/06/14.
//  Copyright (c) 2014 EastBanc Technologies. All rights reserved.
//

#import "ETRStringDecorator.h"

static NSString * const ETRStringDecoratorDefaultPlaceholder = @"#";

@interface ETRStringDecorator ()

@property (nonatomic, copy) NSSet* dataCharactersSet;

@end

@implementation ETRStringDecorator

@synthesize dataCharacters = _dataCharacters;

- (instancetype)initWithFormats:(NSArray *)formats
{
    self = [super init];
    if (self) {
        _formats = [formats copy];
    }
    return self;
}

- (instancetype)initWithDateStringTemplate:(NSString *)stringTemplate
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:stringTemplate options:0 range:NSMakeRange(0, [stringTemplate length]) withTemplate:ETRStringDecoratorDefaultPlaceholder];
    
    NSMutableArray *formats = [NSMutableArray array];
    NSInteger stringLength = modifiedString.length;
    for (NSInteger i = 0; i < stringLength; i++) {
        NSString *characterString = [modifiedString substringWithRange:NSMakeRange(i, 1)];
        if ([characterString isEqualToString:ETRStringDecoratorDefaultPlaceholder]) {
            [formats addObject:[modifiedString substringWithRange:NSMakeRange(0, i + 1)]];
        }
    }
    
    return [self initWithFormats:formats];
}

- (instancetype)init
{
    return [self initWithFormats:nil];
}

+ (NSArray*)charactersOfString:(NSString*)string
{
    NSMutableArray* res = [NSMutableArray array];
    NSRange fullRange = NSMakeRange(0, string.length);
    [string enumerateSubstringsInRange:fullRange
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring,
                                         NSRange substringRange,
                                         NSRange enclosingRange,
                                         BOOL *stop)
     {
         [res addObject:substring];
     }];
    return res;
}

- (NSString *)dataCharacters
{
    if (!_dataCharacters)
        _dataCharacters = @"0123456789";
    return _dataCharacters;
}

- (void)setDataCharacters:(NSString *)dataCharacters
{
    _dataCharacters = [dataCharacters copy];
    _dataCharactersSet = nil;
}

- (NSSet *)dataCharactersSet
{
    if (!_dataCharactersSet) {
        _dataCharactersSet = [NSSet setWithArray:[ETRStringDecorator charactersOfString:self.dataCharacters]];
    }
    return _dataCharactersSet;
}

- (NSString *)placeholderCharacter
{
    if (!_placeholderCharacter) {
        _placeholderCharacter = ETRStringDecoratorDefaultPlaceholder;
    }
    return _placeholderCharacter;
}

- (NSString *)decorateString:(NSString *)dataString
                 usingFormat:(NSString *)format
{
    NSMutableString* res = [NSMutableString string];
    NSArray* dataChars = [ETRStringDecorator charactersOfString:dataString];
    NSArray* formatChars = [ETRStringDecorator charactersOfString:format];
    NSInteger dataIndex = 0;
    for (NSString* formatChar in formatChars) {
        if ([formatChar isEqualToString:self.placeholderCharacter]) {
            if (dataIndex >= dataChars.count)
                return nil;
            [res appendString:dataChars[dataIndex++]];
        } else if ([self.dataCharactersSet containsObject:formatChars]) {
            if (dataIndex >= dataChars.count)
                return nil;
            NSString* dataChar = dataChars[dataIndex++];
            if ([dataChar isEqualToString:formatChar]) {
                [res appendString:dataChar];
            } else {
                return nil;
            }
        } else {
            [res appendString:formatChar];
        }
    }
    if (dataIndex != dataChars.count && format != self.formats.lastObject)
        return nil; // should use all data chars
    return res;
}

- (NSString *)decorateString:(NSString *)dataString
{
    for (NSString* format in self.formats) {
        NSString* res = [self decorateString:dataString
                                 usingFormat:format];
        if (res)
            return res;
    }
    return dataString;
}

- (NSString *)distillString:(NSString *)decoratedString
{
    NSMutableString* res = [NSMutableString string];
    NSArray* decoChars = [ETRStringDecorator charactersOfString:decoratedString];
    for (NSString* decoChar in decoChars) {
        if ([self.dataCharactersSet containsObject:decoChar])
            [res appendString:decoChar];
    }
    return res;
}

- (NSRange)convertRange:(NSRange)range
    fromDecoratedString:(NSString *)decoratedString
{
    NSString* decoPrefix = [decoratedString substringToIndex:range.location];
    NSString* decoSubstring = [decoratedString substringWithRange:range];
    NSString* dataPrefix = [self distillString:decoPrefix];
    NSString* dataSubstring = [self distillString:decoSubstring];
    return NSMakeRange(dataPrefix.length, dataSubstring.length);
}

- (NSInteger)convertLocation:(NSInteger)location
           toDecoratedString:(NSString*)decoratedString
{
    if (location <= 0)
        return location;
    NSInteger res = 0;
    NSArray* decoChars = [ETRStringDecorator charactersOfString:decoratedString];
    for (NSString* decoChar in decoChars) {
        res++;
        if ([self.dataCharactersSet containsObject:decoChar]) {
            location--;
            if (location == 0)
                return res;
        }
    }
    return decoratedString.length;
}

#pragma mark UITextFieldDelegate

-              (BOOL)textItem:(id)textItem
shouldChangeCharactersInRange:(NSRange)range
            replacementString:(NSString *)replacement
{
    NSString* decoString = [textItem text];
    NSRange dataRange = [self convertRange:range
                       fromDecoratedString:decoString];
    NSString* dataReplacement = [self distillString:replacement];
    NSString* dataString = [self distillString:decoString];
    if (range.length > 0 &&
        replacement.length == 0 &&
        dataRange.length == 0 &&
        dataRange.location > 0)
    {
        // probably backspace was hit with no data characters selected or prior to cursor
        // in this case we grow data range by one prior data character (if possible)
        // in order to erase that data character
        dataRange = NSMakeRange(dataRange.location - 1, dataRange.length + 1);
    }
    NSString* newDataString = [dataString stringByReplacingCharactersInRange:dataRange
                                                                  withString:dataReplacement];
    NSString* newDecoString = [self decorateString:newDataString];
    [textItem setText:newDecoString];
    NSInteger newDataLocation = dataRange.location + dataReplacement.length;
    NSInteger newDecoLocation = [self convertLocation:newDataLocation
                                    toDecoratedString:newDecoString];
    UITextPosition* selPos = [textItem positionFromPosition:[textItem beginningOfDocument]
                                                     offset:newDecoLocation];
    UITextRange* selRange = [textItem textRangeFromPosition:selPos
                                                 toPosition:selPos];
    [textItem setSelectedTextRange:selRange];
    return NO;
}

-               (BOOL)textField:(UITextField *)textField
  shouldChangeCharactersInRange:(NSRange)range
              replacementString:(NSString *)replacement
{
    return [self textItem:textField shouldChangeCharactersInRange:range
        replacementString:replacement];
}

-        (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
        replacementText:(NSString *)replacement
{
    return [self textItem:textView shouldChangeCharactersInRange:range replacementString:replacement];
}

@end
