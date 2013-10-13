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
