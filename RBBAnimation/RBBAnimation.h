//
//  RBBAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/10/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef id (^RBBAnimationBlock)(CGFloat t, CGFloat duration);

@interface RBBAnimation : CAKeyframeAnimation

@property (readonly, nonatomic, copy) RBBAnimationBlock animationBlock;

@end

@interface RBBAnimation (Unavailable)

- (void)setValues:(NSArray *)values __attribute__((unavailable("values cannot be set on RBBAnimation")));

@property (readwrite, atomic, assign) CGPathRef path __attribute__((unavailable("path is not available on RBBAnimation")));

@property (readwrite, atomic, copy) NSString *rotationMode __attribute__((unavailable("rotationMode is not available on RBBAnimation")));

@end
