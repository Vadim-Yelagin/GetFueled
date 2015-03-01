//
//  ETRActionSheet.h
//
//  Created by Vadim Yelagin on 01/11/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface ETRActionSheet : UIActionSheet

+ (instancetype)actionSheet;

- (NSInteger)addButtonWithTitle:(NSString*)title action:(void(^)(void))action;
- (NSInteger)addCancelButtonWithTitle:(NSString*)title action:(void(^)(void))action;
- (NSInteger)addDestructiveButtonWithTitle:(NSString*)title action:(void(^)(void))action;

- (void)showFromWhatever;

@property (nonatomic, copy) void (^finalAction)(void);
@property (nonatomic, copy) void (^cancelAction)(void);

@end
