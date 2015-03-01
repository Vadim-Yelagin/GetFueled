//
//  UIImage+ETRUtils.h
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

@import UIKit;

@interface UIImage (ETRUtils)

- (CGAffineTransform)etr_affineTransformToCGImage;

+ (UIImage*)etr_imageWithSize:(CGSize)size
                       opaque:(BOOL)opaque
                        scale:(CGFloat)scale
                     graphics:(void(^)(CGContextRef ctx))graphics;
- (UIImage*)etr_imageTintedWithColor:(UIColor*)color;
- (UIImage*)etr_imageWithAlpha:(CGFloat)alpha;
- (UIImage*)etr_imageStretchedToSize:(CGSize)size;
- (UIImage*)etr_imageThumbWithMaxSize:(CGSize)maxSize
                                scale:(CGFloat)scale;
- (UIImage*)etr_imageCroppedToRect:(CGRect)rect;
+ (UIImage*)etr_imageWithColor:(UIColor*)color
                          size:(CGSize)size;

@end
