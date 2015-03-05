//
//  ETRStoryboardSegue.m
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRStoryboardSegue.h"
#import "ETRStoryboardLink.h"

@implementation ETRStoryboardSegue

+ (UIViewController *)viewControllerFromLink:(UIViewController *)vc
{
    if (![vc isKindOfClass:[ETRStoryboardLink class]])
        return vc;
    ETRStoryboardLink* link = (ETRStoryboardLink*)vc;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:link.storyboardName
                                                          bundle:nil];
    return link.sceneIdentifier.length
        ? [storyboard instantiateViewControllerWithIdentifier:link.sceneIdentifier]
        : [storyboard instantiateInitialViewController];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    destination = [ETRStoryboardSegue viewControllerFromLink:destination];
    self = [super initWithIdentifier:identifier
                              source:source
                         destination:destination];
    if (self) {
        _animated = YES;
    }
    return self;
}

@end
