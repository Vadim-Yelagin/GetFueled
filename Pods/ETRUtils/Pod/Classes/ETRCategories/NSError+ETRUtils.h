//
//  NSError+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import Foundation;

@interface NSError (ETRUtils)

- (BOOL)etr_isCancelledError;

- (NSString *)etr_description;

@end
