//
//  RBBLinearInterpolation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/25/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef id (^RBBLinearInterpolation)(CGFloat fraction);

extern RBBLinearInterpolation RBBInterpolate(NSValue *from, NSValue *to);
