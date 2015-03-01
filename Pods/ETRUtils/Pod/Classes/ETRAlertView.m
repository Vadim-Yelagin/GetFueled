//
//  ETRAlertView.m
//
//  Created by Vadim Yelagin on 9/18/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRAlertView.h"

@interface ETRAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary* actions;

@end

@implementation ETRAlertView

+ (instancetype)alertView
{
    ETRAlertView *res = [[self alloc] init];
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

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView
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

- (void)alertViewCancel:(UIAlertView *)alertView
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
