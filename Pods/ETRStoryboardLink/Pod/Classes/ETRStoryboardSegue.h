//
//  ETRStoryboardSegue.h
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface ETRStoryboardSegue : UIStoryboardSegue

@property (nonatomic, getter = isAnimated) BOOL animated;

+ (UIViewController *)viewControllerFromLink:(UIViewController *)link;

@end
