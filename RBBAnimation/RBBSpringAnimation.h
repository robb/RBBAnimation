//
//  RBBSpringAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/14/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "RBBTweenAnimation.h"

@interface RBBSpringAnimation : RBBTweenAnimation

+ (id)springAnimationWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to mass:(CGFloat)mass stiffness:(CGFloat)stiffness damping:(CGFloat)damping;

@end
