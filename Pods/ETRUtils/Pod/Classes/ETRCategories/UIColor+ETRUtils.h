//
//  UIColor+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface UIColor (ETRUtils)

+ (UIColor *)etr_colorWithHex:(uint32_t)hex;
+ (UIColor *)etr_colorWithHexString:(NSString *)hex;

@end
