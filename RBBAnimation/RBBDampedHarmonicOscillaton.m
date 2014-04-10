//
//  RBBDampedHarmonicOscillaton.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "RBBDampedHarmonicOscillaton.h"

RBBOsciallation RBBDampedHarmonicOscillation(CGFloat x0, CGFloat v0, CGFloat omega0, CGFloat omega1, CGFloat omega2, CGFloat beta) {
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