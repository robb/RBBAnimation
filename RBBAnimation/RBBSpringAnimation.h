//
//  RBBSpringAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface RBBSpringAnimation : CAKeyframeAnimation

@property (readwrite, nonatomic, assign) CGFloat damping;
@property (readwrite, nonatomic, assign) CGFloat mass;
@property (readwrite, nonatomic, assign) CGFloat stiffness;
@property (readwrite, nonatomic, assign) CGFloat velocity;

@property (readwrite, nonatomic, strong) NSValue *from;
@property (readwrite, nonatomic, strong) NSValue *to;

@end

@interface RBBSpringAnimation (Unavailable)

- (void)setValues:(NSArray *)values __attribute__((unavailable("values cannot be set on RBBSpringAnimation")));

@end
