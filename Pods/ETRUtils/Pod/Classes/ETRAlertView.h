//
//  ETRAlertView.h
//
//  Created by Vadim Yelagin on 9/18/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface ETRAlertView : UIAlertView

+ (instancetype)alertView;

- (NSInteger)addButtonWithTitle:(NSString*)title action:(void(^)(void))action;
- (NSInteger)addCancelButtonWithTitle:(NSString*)title action:(void(^)(void))action;

@property (nonatomic, copy) void (^finalAction)(void);
@property (nonatomic, copy) void (^cancelAction)(void);

@end
