//
//  ETRImagePickerController.m
//
//  Created by Vadim Yelagin on 27/02/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRActionSheet.h"
#import "ETRImagePickerController.h"
#import "ETRUtils.h"

@interface ETRImagePickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) BOOL hidesStatusBar;
@property (nonatomic, strong) UIViewController* parent;
@property (nonatomic, copy) void (^completion)(UIImage*);
@property (nonatomic, strong) UIPopoverController *popover;

@end

@implementation ETRImagePickerController

- (BOOL)prefersStatusBarHidden
{
    return self.hidesStatusBar;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return nil;
}

+ (void)presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
                                  sender:(UIView *)sender
                                  parent:(UIViewController *)viewController
                              completion:(void (^)(UIImage *))completion
{
    ETRImagePickerController *ipc = [[ETRImagePickerController alloc] init];
    ipc.delegate = ipc;
    ipc.completion = completion;
    ipc.sourceType = sourceType;
    BOOL showInPopover = NO;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        ipc.hidesStatusBar = YES;
    } else {
        showInPopover = [ETRUtils isIpad];
    }
    if (showInPopover) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:ipc];
        ipc.popover = popover;
        UIView *view = viewController.view;
        CGRect rect = [sender convertRect:sender.bounds
                                   toView:viewController.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [popover presentPopoverFromRect:rect
                                     inView:view
                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                   animated:YES];
        });
    } else {
        ipc.parent = viewController;
        [viewController presentViewController:ipc animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.completion)
        self.completion(image);
    
    if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    } else {
        [self.parent dismissViewControllerAnimated:YES completion:nil];
        self.parent = nil;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.completion)
        self.completion(nil);
    
    if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    } else {
        [self.parent dismissViewControllerAnimated:YES completion:nil];
        self.parent = nil;
    }
}

@end
