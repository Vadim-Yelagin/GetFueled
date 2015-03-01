//
//  ETRCGUtils.h
//
//  Created by Vadim Yelagin on 03/12/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

@import CoreGraphics;
@import Foundation;

extern CGPoint ETRPointAdd(CGPoint a, CGPoint b);
extern CGPoint ETRPointSub(CGPoint a, CGPoint b);
extern CGPoint ETRPointNeg(CGPoint a);
extern CGFloat ETRPointDot(CGPoint a, CGPoint b);
extern CGFloat ETRPointCross(CGPoint a, CGPoint b);
extern CGPoint ETRPointMul(CGFloat a, CGPoint b);
extern NSComparisonResult ETRSign(CGFloat a);

@interface NSArray (ETRCGUtils)

- (NSArray*)convexHull;

@end
