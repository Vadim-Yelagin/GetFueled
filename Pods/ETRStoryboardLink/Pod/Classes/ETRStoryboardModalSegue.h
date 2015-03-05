//
//  ETRStoryboardModalSegue.h
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRStoryboardSegue.h"

@interface ETRStoryboardModalSegue : ETRStoryboardSegue

@property (nonatomic) UIModalPresentationStyle presentationStyle;
@property (nonatomic, copy) void (^completion)(void);

@end
