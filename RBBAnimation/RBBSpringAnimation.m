//
//  RBBSpringAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBSpringAnimation.h"

@implementation RBBSpringAnimation

+ (id)springAnimationWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to mass:(CGFloat)m stiffness:(CGFloat)k damping:(CGFloat)b {
    NSParameterAssert(m > 0);
    NSParameterAssert(k > 0);
    NSParameterAssert(b > 0);

    CGFloat beta = b / (2 * m);
    CGFloat omega0 = sqrtf(k / m);
    CGFloat omega1 = sqrtf((omega0 * omega0) - (beta * beta));
    CGFloat omega2 = sqrtf((beta * beta) - (omega0 * omega0));

    CGFloat v0 = 0;
    CGFloat x0 = -1;

    RBBInterpolationFunction damping;

    if (beta < omega0) {
        // Underdamped
        damping = ^(CGFloat t, CGFloat duration) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * cosf(omega1 * t) + ((beta * x0 + v0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        damping = ^(CGFloat t, CGFloat duration) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 + (beta * x0 + v0) * t);
        };
    } else {
        // Overdamped
        damping = ^(CGFloat t, CGFloat duration) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * coshf(omega2 * t) + ((beta * x0 + v0) / omega2) * sinhf(omega2 * t));
        };
    }

    return [self tweenWithKeyPath:keyPath from:from to:to interpolation:damping];
}

@end
