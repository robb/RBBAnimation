//
//  RBBSpringAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"
#import "RBBDampedHarmonicOscillaton.h"
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

    self.calculationMode = kCAAnimationDiscrete;

    return self;
}

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingAnimationBlock {
    return [NSSet setWithArray:@[
        @"damping",
        @"mass",
        @"stiffness",
        @"velocity",
        @"fromValue",
        @"toValue",
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
    CGFloat (^oscillation)(CGFloat) = RBBDampedHarmonicOscillation(-1, self.damping, self.mass, self.stiffness, self.velocity, self.allowsOverdamping);

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
