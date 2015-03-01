//
//  ETRCGUtils.m
//
//  Created by Vadim Yelagin on 03/12/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRCGUtils.h"
#import "ETRUtils.h"

CGPoint ETRPointAdd(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

CGPoint ETRPointSub(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}

CGPoint ETRPointNeg(CGPoint a)
{
    return CGPointMake(-a.x, -a.y);
}

CGFloat ETRPointDot(CGPoint a, CGPoint b)
{
    return a.x * b.x + a.y * b.y;
}

CGFloat ETRPointCross(CGPoint a, CGPoint b)
{
    return a.x * b.y - a.y * b.x;
}

CGPoint ETRPointMul(CGFloat a, CGPoint b)
{
    return CGPointMake(a * b.x, a * b.y);
}

NSComparisonResult ETRSign(CGFloat a)
{
    if (a < 0)
        return NSOrderedAscending;
    if (a > 0)
        return NSOrderedDescending;
    return NSOrderedSame;
}

static BOOL ETRConvexViolation(NSArray* array, CGPoint newPoint)
{
    NSInteger n = array.count;
    if (n < 2)
        return NO;
    CGPoint p1 = [array[n-1] CGPointValue];
    CGPoint p2 = [array[n-2] CGPointValue];
    CGPoint p21 = ETRPointSub(p1, p2);
    CGPoint p10 = ETRPointSub(newPoint, p1);
    CGFloat cross = ETRPointCross(p21, p10);
    return cross >= 0;
}

@implementation NSArray (ETRCGUtils)

- (NSArray *)convexHull
{
    NSInteger idx = [self etr_minimumUsingComparator:^NSComparisonResult(NSValue* obj1, NSValue* obj2)
                     {
                         return ETRSign(obj1.CGPointValue.x +
                                        obj1.CGPointValue.y -
                                        obj2.CGPointValue.x -
                                        obj2.CGPointValue.y);
                     }];
    if (idx == NSNotFound)
        return @[];
    CGPoint a = [self[idx] CGPointValue];
    NSMutableArray* sorted = [self mutableCopy];
    [sorted removeObjectAtIndex:idx];
    [sorted sortUsingComparator:^NSComparisonResult(NSValue* obj1, NSValue* obj2)
     {
         CGPoint a1 = ETRPointSub(obj1.CGPointValue, a);
         CGPoint a2 = ETRPointSub(obj2.CGPointValue, a);
         CGFloat a12 = ETRPointCross(a1, a2);
         return ETRSign(a12);
     }];
    NSMutableArray* res = [NSMutableArray arrayWithObject:[NSValue valueWithCGPoint:a]];
    for (NSValue* obj in sorted) {
        while (ETRConvexViolation(res, [obj CGPointValue])) {
            [res removeLastObject];
        }
        [res addObject:obj];
    }
    while (ETRConvexViolation(res, a)) {
        [res removeLastObject];
    }
    return [res copy];
}

@end
