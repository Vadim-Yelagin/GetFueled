//
//  NSString+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSString (ETRUtils)

- (NSInteger)etr_numberOfWords;
- (NSString*)etr_stringBySafeAppend:(NSString*)string;
- (NSDecimalNumber*)etr_decimalNumberValue;
- (NSString*)etr_stringByRemovingNonBMPCharacters;

@end
