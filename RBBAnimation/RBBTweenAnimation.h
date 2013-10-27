//
//  RBBTweenAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

#import "RBBEasingFunction.h"

typedef CGFloat (^RBBScalingFunction)(CGFloat elapsed, CGFloat duration);

@interface RBBTweenAnimation : RBBAnimation

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to;

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to easingFunction:(RBBEasingFunction)easingFunction;

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to interpolation:(RBBScalingFunction)scalingFunction;

@end
