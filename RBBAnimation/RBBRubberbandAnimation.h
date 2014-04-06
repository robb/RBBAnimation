//
//  RBBRubberbandAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 06/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#ifdef CGVECTOR_DEFINED
typedef CGVector RBBVector;
#else
struct RBBVector {
    CGFloat dx;
    CGFloat dy;
};
typedef struct RBBVector RBBVector;
#endif

#import "RBBAnimation.h"

@interface RBBRubberbandAnimation : RBBAnimation

@property (readwrite, nonatomic, assign) CGFloat damping;
@property (readwrite, nonatomic, assign) CGFloat mass;
@property (readwrite, nonatomic, assign) CGFloat stiffness;
@property (readwrite, nonatomic, assign) RBBVector velocity;

@property (readwrite, nonatomic, assign) CGPoint from;
@property (readwrite, nonatomic, assign) CGPoint to;

@property (readwrite, nonatomic, assign) BOOL allowsOverdamping;

- (CFTimeInterval)durationForEpsilon:(double)epsilon;

@end
