//
//  RBBTweenAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RBBLinearInterpolation.h"

#import "RBBTweenAnimation.h"

@implementation RBBTweenAnimation

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to {
    return [self tweenWithKeyPath:keyPath from:from to:to easingFunction:RBBEasingFunctionLinear];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to easingFunction:(RBBEasingFunction)easingFunction {
    RBBLinearInterpolation lerp = RBBInterpolate(from, to);

    return [self animationWithKeyPath:keyPath block:^id(CGFloat t, CGFloat duration) {
        return lerp(easingFunction(t / duration));
    }];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to interpolation:(RBBScalingFunction)scalingFunction {
    RBBLinearInterpolation lerp = RBBInterpolate(from, to);

    return [self animationWithKeyPath:keyPath block:^id(CGFloat t, CGFloat duration) {
        return lerp(scalingFunction(t, duration));
    }];
}

@end
