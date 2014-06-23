//
//  RBBRubberbandAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 06/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "NSValue+PlatformIndependence.h"

#import "RBBDampedHarmonicOscillaton.h"

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
    CGFloat deltaX = self.from.x - self.to.x;
    CGFloat deltaY = self.from.y - self.to.y;

    RBBOsciallation oscillationX = RBBDampedHarmonicOscillation(deltaX, self.damping, self.mass, self.stiffness, self.velocity.x, self.allowsOverdamping);
    RBBOsciallation oscillationY = RBBDampedHarmonicOscillation(deltaY, self.damping, self.mass, self.stiffness, self.velocity.y, self.allowsOverdamping);

    CGFloat x0 = self.to.x;
    CGFloat y0 = self.to.y;

    return ^(CGFloat t, CGFloat _) {
        CGPoint p = { .x = x0 + oscillationX(t), .y = y0 + oscillationY(t) };

        return [NSValue rbb_valueWithCGPoint:p];
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
