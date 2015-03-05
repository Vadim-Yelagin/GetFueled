//
//  AppDelegate.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "AppDelegate.h"
#import <ETRUtils/ETRUtils.h>
#import <RestKit/RestKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.tintColor = [UIColor etr_colorWithHex:0xae0000];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return YES;
}

@end
