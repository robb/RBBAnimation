//
//  RBBEasingFunction.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBEasingFunction.h"

#if CGFLOAT_IS_DOUBLE
#define POW(X, Y) pow(X, Y)
#else
#define POW(X, Y) powf(X, Y)
#endif

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
    return POW(t - 1, 3) + 1;
};

RBBEasingFunction const RBBEasingFunctionEaseInOutCubic = ^(CGFloat t) {
    if (t < 0.5) {
        return 4 * POW(t, 3);
    } else {
        return (t - 1) * POW(2 * t - 2, 2) + 1;
    }
};

RBBEasingFunction const RBBEasingFunctionEaseInQuart = ^(CGFloat t) {
    return t * t * t * t;
};

RBBEasingFunction const RBBEasingFunctionEaseOutQuart = ^(CGFloat t) {
    return POW(t - 1, 4) + 1;
};

RBBEasingFunction const RBBEasingFunctionEaseInOutQuart = ^(CGFloat t) {
    if (t < 0.5) {
        return 8 * POW(t, 4);
    } else {
        return -1 / 2 * POW(2 * t - 2, 4) + 1;
    }
};

RBBEasingFunction const RBBEasingFunctionEaseInBounce = ^CGFloat(CGFloat t) {
    return 1.0 - RBBEasingFunctionEaseOutBounce(1.0 - t);
};

RBBEasingFunction const RBBEasingFunctionEaseOutBounce = ^CGFloat(CGFloat t) {
    if (t < 4.0 / 11.0) {
        return POW(11.0 / 4.0, 2) * POW(t, 2);
    }

    if (t < 8.0 / 11.0) {
        return 3.0 / 4.0 + POW(11.0 / 4.0, 2) * POW(t - 6.0 / 11.0, 2);
    }

    if (t < 10.0 / 11.0) {
        return 15.0 /16.0 + POW(11.0 / 4.0, 2) * POW(t - 9.0 / 11.0, 2);
    }

    return 63.0 / 64.0 + POW(11.0 / 4.0, 2) * POW(t - 21.0 / 22.0, 2);
};
