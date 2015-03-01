//
//  UIView+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "UIView+ETRUtils.h"

@implementation UIView (ETRUtils)

- (UIView *)etr_findFirstResponder
{
    if (self.isFirstResponder)
        return self;
    for (UIView* subview in self.subviews) {
        UIView* fr = [subview etr_findFirstResponder];
        if (fr)
            return fr;
    }
    return nil;
}

- (void)setParallaxAmplitude:(CGFloat)amplitude
{
    if (![self respondsToSelector:@selector(addMotionEffect:)])
        return;
    
    static NSMutableDictionary* cache = nil;
    if (!cache)
        cache = [NSMutableDictionary dictionary];
    
    UIMotionEffectGroup* group = cache[@(amplitude)];
    if (!group) {
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-amplitude);
        verticalMotionEffect.maximumRelativeValue = @(amplitude);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-amplitude);
        horizontalMotionEffect.maximumRelativeValue = @(amplitude);
        
        group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        
        cache[@(amplitude)] = group;
    }
    [self addMotionEffect:group];
}

- (CGFloat)parallaxAmplitude
{
    return 0; // stub
}

@end
