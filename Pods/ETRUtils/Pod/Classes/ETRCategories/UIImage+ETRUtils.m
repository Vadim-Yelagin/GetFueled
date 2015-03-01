//
//  UIImage+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UIImage+ETRUtils.h"

@implementation UIImage (ETRUtils)

- (CGAffineTransform)etr_affineTransformToCGImage
{
    CGImageRef img = self.CGImage;
    CGFloat width = CGImageGetWidth(img);
    CGFloat height = CGImageGetHeight(img);
    CGAffineTransform transform;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0, height);
            transform = CGAffineTransformScale(transform, 1, -1);
            break;
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1, 1);
            transform = CGAffineTransformRotate(transform, -M_PI / 2);
            break;
        case UIImageOrientationLeft:
            transform = CGAffineTransformMakeTranslation(0, width);
            transform = CGAffineTransformRotate(transform, -M_PI / 2);
            break;
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformMakeScale(-1, 1);
            transform = CGAffineTransformRotate(transform, M_PI / 2);
            break;
        case UIImageOrientationRight:
            transform = CGAffineTransformMakeTranslation(height, 0);
            transform = CGAffineTransformRotate(transform, M_PI / 2);
            break;
    }
    transform = CGAffineTransformInvert(transform);
    transform = CGAffineTransformScale(transform, self.scale, self.scale);
    return transform;
}

+ (UIImage *)etr_imageWithSize:(CGSize)size
                        opaque:(BOOL)opaque
                         scale:(CGFloat)scale
                      graphics:(void (^)(CGContextRef))graphics
{
    UIImage* image = nil;
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        if (graphics) {
            @try {
                graphics(UIGraphicsGetCurrentContext());
            }
            @catch (id exception) {
                NSLog(@"Exception while drawing: %@", exception);
            }
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

- (UIImage *)etr_imageTintedWithColor:(UIColor *)color
{
    UIImage *res = [UIImage etr_imageWithSize:self.size
                                       opaque:NO
                                        scale:self.scale
                                     graphics:^(CGContextRef ctx)
                    {
                        [color setFill];
                        UIRectFill(CGRectMake(0, 0,
                                              self.size.width,
                                              self.size.height));
                        [self drawAtPoint:CGPointZero
                                blendMode:kCGBlendModeDestinationIn
                                    alpha:1];
                    }];
    if (!UIEdgeInsetsEqualToEdgeInsets(self.capInsets, UIEdgeInsetsZero)) {
        res = [res resizableImageWithCapInsets:self.capInsets
                                  resizingMode:self.resizingMode];
    }
    return res;
}

- (UIImage *)etr_imageWithAlpha:(CGFloat)alpha
{
    return [UIImage etr_imageWithSize:self.size
                               opaque:NO
                                scale:self.scale
                             graphics:^(CGContextRef ctx)
            {
                [self drawAtPoint:CGPointZero
                        blendMode:kCGBlendModeNormal
                            alpha:alpha];
            }];
}

- (UIImage *)etr_imageStretchedToSize:(CGSize)size
{
    return [UIImage etr_imageWithSize:size
                               opaque:YES
                                scale:1
                             graphics:^(CGContextRef ctx)
            {
                [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
            }];
}

- (UIImage *)etr_imageThumbWithMaxSize:(CGSize)maxSize
                                 scale:(CGFloat)scale
{
    CGFloat w = self.size.width * self.scale;
    CGFloat h = self.size.height * self.scale;
    if (w <= maxSize.width * scale && h <= maxSize.height * scale) {
        return [UIImage imageWithCGImage:self.CGImage
                                   scale:scale
                             orientation:self.imageOrientation];
    }
    CGSize newSize;
    if (maxSize.height * w > maxSize.width * h) {
        newSize = CGSizeMake(maxSize.width, roundf(maxSize.width * h / w));
    } else {
        newSize = CGSizeMake(roundf(maxSize.height * w / h), maxSize.height);
    }
    return [UIImage etr_imageWithSize:newSize
                               opaque:YES
                                scale:scale
                             graphics:^(CGContextRef ctx)
            {
                [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            }];
}

- (UIImage *)etr_imageCroppedToRect:(CGRect)rect
{
    CGAffineTransform rectTransform = self.etr_affineTransformToCGImage;
    CGRect rectInCGImage = CGRectApplyAffineTransform(rect, rectTransform);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rectInCGImage);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

+ (UIImage *)etr_imageWithColor:(UIColor *)color
                           size:(CGSize)size
{
    return [UIImage etr_imageWithSize:size
                               opaque:NO
                                scale:0
                             graphics:^(CGContextRef ctx)
            {
                [color setFill];
                UIRectFill(CGRectMake(0, 0, size.width, size.height));
            }];
}

@end
