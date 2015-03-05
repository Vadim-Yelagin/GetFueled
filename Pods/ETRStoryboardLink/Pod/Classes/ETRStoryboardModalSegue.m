//
//  ETRStoryboardModalSegue.m
//
//  Created by Vadim Yelagin on 15/01/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRStoryboardModalSegue.h"

@implementation ETRStoryboardModalSegue

- (void)perform
{
    [self.destinationViewController setModalPresentationStyle:self.presentationStyle];
    [self.sourceViewController presentViewController:self.destinationViewController
                                            animated:self.animated
                                          completion:self.completion];
}

@end
