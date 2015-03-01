//
//  ETRRACAdditions.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal (ETROperations)

- (RACSignal *)formatWithDateFormatter:(NSDateFormatter*)dateFormatter;

@end

@interface NSLocale (RACSupport)

+ (RACSignal *)rac_currentLocale;

@end

@interface NSTimeZone (RACSupport)

+ (RACSignal *)rac_systemTimeZone;

@end
