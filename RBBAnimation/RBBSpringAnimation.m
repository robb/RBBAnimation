//
//  RBBSpringAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"
#import "RBBLinearInterpolation.h"

#import "RBBSpringAnimation.h"

@implementation RBBSpringAnimation

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
    return [NSSet setWithArray:@[ @"damping", @"mass", @"stiffness", @"velocity", @"from", @"to", @"allowsOverdamping" ]];
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
    CGFloat v0 = self.velocity;

    NSParameterAssert(m > 0);
    NSParameterAssert(k > 0);
    NSParameterAssert(b > 0);

    CGFloat beta = b / (2 * m);
    CGFloat omega0 = sqrtf(k / m);
    CGFloat omega1 = sqrtf((omega0 * omega0) - (beta * beta));
    CGFloat omega2 = sqrtf((beta * beta) - (omega0 * omega0));

    CGFloat x0 = -1;

    if (!self.allowsOverdamping && beta > omega0) beta = omega0;

    CGFloat (^oscillation)(CGFloat);
    if (beta < omega0) {
        // Underdamped
        oscillation = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * cosf(omega1 * t) + ((beta * x0 + v0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        oscillation = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 + (beta * x0 + v0) * t);
        };
    } else {
        // Overdamped
        oscillation = ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * coshf(omega2 * t) + ((beta * x0 + v0) / omega2) * sinhf(omega2 * t));
        };
    }

    RBBLinearInterpolation lerp = RBBInterpolate(self.fromValue, self.toValue);
    return ^(CGFloat t, CGFloat _) {
        return lerp(oscillation(t));
    };
}

#pragma mark - NSObject

- (id)copyWithZone:(NSZone *)zone {
    RBBSpringAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;

    copy->_damping = _damping;
    copy->_mass = _mass;
    copy->_stiffness = _stiffness;
    copy->_velocity = _velocity;

    copy->_fromValue = _fromValue;
    copy->_toValue = _toValue;

    copy->_allowsOverdamping = _allowsOverdamping;

    return copy;
}

@end
