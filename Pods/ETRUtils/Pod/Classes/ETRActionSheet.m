//
//  ETRActionSheet.m
//
//  Created by Vadim Yelagin on 01/11/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRActionSheet.h"

@interface ETRActionSheet () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableDictionary* actions;

@end

@implementation ETRActionSheet

+ (instancetype)actionSheet
{
    ETRActionSheet *res = [[self alloc] init];
    res.delegate = res;
    return res;
}

- (NSMutableDictionary *)actions
{
    if (!_actions) {
        _actions = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _actions;
}

- (NSInteger)addButtonWithTitle:(NSString *)title
                         action:(void (^)(void))action
{
    NSInteger idx = [self addButtonWithTitle:title];
    if (action) {
        self.actions[@(idx)] = [action copy];
    }
    return idx;
}

- (NSInteger)addCancelButtonWithTitle:(NSString *)title
                               action:(void (^)(void))action
{
    NSInteger idx = [self addButtonWithTitle:title action:action];
    self.cancelButtonIndex = idx;
    return idx;
}

- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title
                                    action:(void (^)(void))action
{
    NSInteger idx = [self addButtonWithTitle:title action:action];
    self.destructiveButtonIndex = idx;
    return idx;
}

- (void)showFromWhatever
{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tbc = (UITabBarController*)vc;
        [self showFromTabBar:tbc.tabBar];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nc = (UINavigationController*)vc;
        [self showFromToolbar:nc.toolbar];
    } else {
        [self showInView:vc.view];
    }
}

#pragma mark UIActionSheetDelegate

-  (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^action)(void) = self.actions[@(buttonIndex)];
    if (action) {
        action();
    }
    if (self.finalAction) {
        self.finalAction();
    }
    self.actions = nil;
    self.finalAction = nil;
    self.cancelAction = nil;
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (self.cancelAction) {
        self.cancelAction();
    }
    if (self.finalAction) {
        self.finalAction();
    }
    self.actions = nil;
    self.finalAction = nil;
    self.cancelAction = nil;
}

@end