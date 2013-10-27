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

@interface RBBSpringAnimation ()

@property (readonly, nonatomic, copy) CGFloat (^oscillation)(CGFloat);

@end

@implementation RBBSpringAnimation

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingValues {
    return [NSSet setWithArray:@[ @"oscillation", @"duration", @"from", @"to" ]];
}

+ (NSSet *)keyPathsForValuesAffectingOscillation {
    return [NSSet setWithArray:@[ @"damping", @"mass", @"stiffness", @"velocity" ]];
}

#pragma mark - RBBSpringAnimation

- (CGFloat (^)(CGFloat))oscillation {
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

    if (beta < omega0) {
        // Underdamped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * cosf(omega1 * t) + ((beta * x0 + v0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 + (beta * x0 + v0) * t);
        };
    } else {
        // Overdamped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return -x0 + envelope * (x0 * coshf(omega2 * t) + ((beta * x0 + v0) / omega2) * sinhf(omega2 * t));
        };
    }
}

#pragma mark - CAKeyframeAnimation

- (void)setValues:(NSArray *)values {
    return;
}

- (NSArray *)values {
    CGFloat (^oscillation)(CGFloat) = [self.oscillation copy];
    RBBLinearInterpolation lerp = RBBInterpolate(self.from, self.to);

    return [RBBBlockBasedArray arrayWithCount:self.duration * 60 block:^id(NSUInteger idx) {
        return lerp(oscillation(idx / 60.0));
    }];
}

#pragma mark - NSObject

- (id)copyWithZone:(NSZone *)zone {
    RBBSpringAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;

    copy->_damping = _damping;
    copy->_mass = _mass;
    copy->_stiffness = _stiffness;
    copy->_velocity = _velocity;

    copy->_from = _from;
    copy->_to = _to;

    return copy;
}

@end
