//
//  ETRStoryboardPopoverSegue.m
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRStoryboardPopoverSegue.h"
#import "ETRStoryboardSegue.h"

@implementation ETRStoryboardPopoverSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    destination = [ETRStoryboardSegue viewControllerFromLink:destination];
    return [super initWithIdentifier:identifier
                              source:source
                         destination:destination];
}

@end
