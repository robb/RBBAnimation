//
//  RBBDampedHarmonicOscillaton.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "RBBDampedHarmonicOscillaton.h"

RBBOsciallation RBBDampedHarmonicOscillation(CGFloat x0, CGFloat b, CGFloat m, CGFloat k, CGFloat v0, BOOL allowsOverdamping) {
    NSCAssert(m > 0, @"mass must be greater than zero.");
    NSCAssert(k > 0, @"stiffness must be greater than zero.");
    NSCAssert(b > 0, @"damping must be greater than zero.");

    CGFloat beta = b / (2 * m);
    CGFloat omega0 = sqrtf(k / m);
    CGFloat omega1 = sqrtf((omega0 * omega0) - (beta * beta));
    CGFloat omega2 = sqrtf((beta * beta) - (omega0 * omega0));

    if (!allowsOverdamping && beta > omega0) beta = omega0;

    if (beta < omega0) {
        // Underdamped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return envelope * (x0 * cosf(omega1 * t) + ((beta * x0 + v0) / omega1) * sinf(omega1 * t));
        };
    } else if (beta == omega0) {
        // Critically damped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return envelope * (x0 + (beta * x0 + v0) * t);
        };
    } else {
        // Overdamped
        return ^(CGFloat t) {
            CGFloat envelope = expf(-beta * t);

            return envelope * (x0 * coshf(omega2 * t) + ((beta * x0 + v0) / omega2) * sinhf(omega2 * t));
        };
    }
}