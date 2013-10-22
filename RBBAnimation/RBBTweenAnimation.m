//
//  RBBTweenAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RBBTweenAnimation.h"

@interface RBBTweenAnimation ()

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGFloat:(CGFloat)from toCGFloat:(CGFloat)to interpolation:(RBBInterpolationFunction)interpolation;
+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGRect:(CGRect)from toCGRect:(CGRect)to interpolation:(RBBInterpolationFunction)interpolation;
+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGPoint:(CGPoint)from toCGPoint:(CGPoint)to interpolation:(RBBInterpolationFunction)interpolation;

@end

@implementation RBBTweenAnimation

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to {
    return [self tweenWithKeyPath:keyPath from:from to:to easingFunction:RBBEasingFunctionLinear];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to easingFunction:(RBBEasingFunction)easingFunction {
    return [self tweenWithKeyPath:keyPath from:from to:to interpolation:^CGFloat(CGFloat elapsed, CGFloat duration) {
        return easingFunction(elapsed / duration);
    }];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to interpolation:(RBBInterpolationFunction)interpolation {
    NSParameterAssert(strcmp(from.objCType, to.objCType) == 0);

    if (strcmp(from.objCType, @encode(CGRect)) == 0) {
        return [self tweenWithKeyPath:keyPath fromCGRect:[from CGRectValue] toCGRect:[to CGRectValue] interpolation:interpolation];
    }

    if (strcmp(from.objCType, @encode(CGPoint)) == 0) {
        return [self tweenWithKeyPath:keyPath fromCGPoint:[from CGPointValue] toCGPoint:[to CGPointValue] interpolation:interpolation];
    }

    if ([from isKindOfClass:NSNumber.class]) {
        return [self tweenWithKeyPath:keyPath fromCGFloat:[(NSNumber *) from floatValue] toCGFloat:[(NSNumber *) to floatValue] interpolation:interpolation];
    }

    NSAssert(NO, @"Unsupported value type: %s", from.objCType);
    return nil;
}

#pragma mark - Interpolation

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGRect:(CGRect)from toCGRect:(CGRect)to interpolation:(RBBInterpolationFunction)interpolation {
    CGFloat deltaX = to.origin.x - from.origin.x;
    CGFloat deltaY = to.origin.y - from.origin.y;
    CGFloat deltaWidth = to.size.width - from.size.width;
    CGFloat deltaHeight = to.size.height - from.size.height;

    RBBAnimationBlock block = ^(CGFloat elapsed, CGFloat duration) {
        CGFloat scaleFactor = interpolation(elapsed, duration);

        CGRect rect = {
            .origin.x = from.origin.x + scaleFactor * deltaX,
            .origin.y = from.origin.y + scaleFactor * deltaY,
            .size.width = from.size.width + scaleFactor * deltaWidth,
            .size.height = from.size.height + scaleFactor * deltaHeight
        };

        return [NSValue valueWithCGRect:rect];
    };

    return [self animationWithKeyPath:keyPath block:block];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGPoint:(CGPoint)from toCGPoint:(CGPoint)to interpolation:(RBBInterpolationFunction)interpolation {
    CGFloat deltaX = to.x - from.x;
    CGFloat deltaY = to.y - from.y;

    RBBAnimationBlock block = ^(CGFloat elapsed, CGFloat duration) {
        CGFloat scaleFactor = interpolation(elapsed, duration);

        CGPoint point = {
            .x = from.x + scaleFactor * deltaX,
            .y = from.y + scaleFactor * deltaY
        };

        return [NSValue valueWithCGPoint:point];
    };

    return [self animationWithKeyPath:keyPath block:block];
}

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGFloat:(CGFloat)from toCGFloat:(CGFloat)to interpolation:(RBBInterpolationFunction)interpolation {
    CGFloat delta = to - from;

    RBBAnimationBlock block = ^(CGFloat elapsed, CGFloat duration) {
        return @(from + interpolation(elapsed, duration) * delta);
    };

    return [self animationWithKeyPath:keyPath block:block];
}

@end
