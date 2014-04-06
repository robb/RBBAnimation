//
//  RBBRubberbandAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 06/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#endif

#import "RBBRubberbandAnimation.h"

@implementation RBBRubberbandAnimation

#pragma mark - Lifecycle

- (id)init {
    self = [super init];
    if (self == nil) return nil;

    self.damping = 10;
    self.mass = 1;
    self.stiffness = 100;

    return self;
}

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingAnimationBlock {
    return [NSSet setWithArray:@[
        @"damping",
        @"mass",
        @"stiffness",
        @"velocity",
        @"from",
        @"to",
        @"allowsOverdamping"
    ]];
}

#pragma mark - RBBSpringAnimation

- (CFTimeInterval)durationForEpsilon:(double)epsilon {
    CGFloat beta = self.damping / (2 * self.mass);

    CFTimeInterval duration = 0;
    while (expf(-beta * duration) >= epsilon) {
        duration += 0.1;
    }

    return duration;
}

#pragma mark - RBBAnimation

- (RBBAnimationBlock)animationBlock {
    CGFloat b = self.damping;
    CGFloat m = self.mass;
    CGFloat k = self.stiffness;
    CGFloat v_x0 = self.velocity.x;
    CGFloat v_y0 = self.velocity.y;

    NSParameterAssert(m > 0);
    NSParameterAssert(k > 0);
    NSParameterAssert(b > 0);

    CGFloat beta = b / (2 * m);
    CGFloat omega0 = sqrtf(k / m);
    CGFloat omega1 = sqrtf((omega0 * omega0) - (beta * beta));
    CGFloat omega2 = sqrtf((beta * beta) - (omega0 * omega0));

    CGFloat x0 = self.from.x - self.to.x;
    CGFloat y0 = self.from.y - self.to.y;

    if (!self.allowsOverdamping && beta > omega0) beta = omega0;

    CGFloat (^oscillationX)(CGFloat);
    if (beta < omega0) {
        // Underdamped
        oscillationX = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * cosf(omega1 * t) + ((beta * x0 + v_x0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        oscillationX = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 + (beta * x0 + v_x0) * t);
        };
    } else {
        // Overdamped
        oscillationX = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * coshf(omega2 * t) + ((beta * x0 + v_x0) / omega2) * sinhf(omega2 * t));
        };
    }

    CGFloat (^oscillationY)(CGFloat);
    if (beta < omega0) {
        // Underdamped
        oscillationY = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -y0 + envelope * (y0 * cosf(omega1 * t) + ((beta * y0 + v_y0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        oscillationY = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -y0 + envelope * (y0 + (beta * y0 + v_y0) * t);
        };
    } else {
        // Overdamped
        oscillationY = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -y0 + envelope * (y0 * coshf(omega2 * t) + ((beta * y0 + v_y0) / omega2) * sinhf(omega2 * t));
        };
    }

    return ^(CGFloat t, CGFloat _) {
        CGPoint p = { .x = self.from.x + oscillationX(t), .y = self.from.y + oscillationY(t) };

        #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        return [NSValue valueWithCGPoint:p];
        #elif TARGET_OS_MAC
        return [NSValue valueWithPoint:p];
        #endif
    };
}

#pragma mark - NSObject

- (id)copyWithZone:(NSZone *)zone {
    RBBRubberbandAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;
    
    copy->_damping = _damping;
    copy->_mass = _mass;
    copy->_stiffness = _stiffness;
    copy->_velocity = _velocity;
    
    copy->_from = _from;
    copy->_to = _to;
    
    copy->_allowsOverdamping = _allowsOverdamping;
    
    return copy;
}

@end
