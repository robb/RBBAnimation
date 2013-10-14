//
//  RBBEasingFunction.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBEasingFunction.h"

RBBEasingFunction const RBBEasingFunctionLinear = ^(CGFloat t) {
    return t;
};

RBBEasingFunction const RBBEasingFunctionEaseInQuad = ^(CGFloat t) {
    return t * t;
};

RBBEasingFunction const RBBEasingFunctionEaseOutQuad = ^(CGFloat t) {
    return t * (2 - t);
};

RBBEasingFunction const RBBEasingFunctionEaseInOutQuad = ^(CGFloat t) {
    if (t < 0.5) {
        return 2 * t * t;
    } else {
        return -1 + (4 - 2 * t) * t;
    }
};

RBBEasingFunction const RBBEasingFunctionEaseInCubic = ^(CGFloat t) {
    return t * t * t;
};

RBBEasingFunction const RBBEasingFunctionEaseOutCubic = ^(CGFloat t) {
    return powf(t - 1, 3) + 1;
};

RBBEasingFunction const RBBEasingFunctionEaseInOutCubic = ^(CGFloat t) {
    if (t < 0.5) {
        return 4 * powf(t, 3);
    } else {
        return (t - 1) * powf(2 * t - 2, 2) + 1;
    }
};
