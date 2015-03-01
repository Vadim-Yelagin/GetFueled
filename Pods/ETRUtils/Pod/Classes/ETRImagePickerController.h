//
//  ETRImagePickerController.h
//
//  Created by Vadim Yelagin on 27/02/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface ETRImagePickerController : UIImagePickerController

+ (void)presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
                                  sender:(UIView *)sender
                                  parent:(UIViewController *)viewController
                              completion:(void (^)(UIImage *))completion;

@end
