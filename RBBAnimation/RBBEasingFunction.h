//
//  RBBEasingFunction.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef CGFloat (^RBBEasingFunction)(CGFloat t);

extern RBBEasingFunction const RBBEasingFunctionLinear;

extern RBBEasingFunction const RBBEasingFunctionEaseInQuad;
extern RBBEasingFunction const RBBEasingFunctionEaseOutQuad;
extern RBBEasingFunction const RBBEasingFunctionEaseInOutQuad;

extern RBBEasingFunction const RBBEasingFunctionEaseInCubic;
extern RBBEasingFunction const RBBEasingFunctionEaseOutCubic;
extern RBBEasingFunction const RBBEasingFunctionEaseInOutCubic;

extern RBBEasingFunction const RBBEasingFunctionEaseInQuart;
extern RBBEasingFunction const RBBEasingFunctionEaseOutQuart;
extern RBBEasingFunction const RBBEasingFunctionEaseInOutQuart;

extern RBBEasingFunction const RBBEasingFunctionEaseInBounce;
extern RBBEasingFunction const RBBEasingFunctionEaseOutBounce;
