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
+ (id)tweenWithKeyPath:(NSString *)keyPath fromCATransform3D:(CATransform3D)from toCATransform3D:(CATransform3D)to interpolation:(RBBInterpolationFunction)interpolation;

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

    if (strcmp(from.objCType, @encode(CATransform3D)) == 0) {
        return [self tweenWithKeyPath:keyPath fromCATransform3D:[from CATransform3DValue] toCATransform3D:[to CATransform3DValue] interpolation:interpolation];
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

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCATransform3D:(CATransform3D)from toCATransform3D:(CATransform3D)to interpolation:(RBBInterpolationFunction)interpolation {
    CATransform3D delta = {
        .m11 = to.m11 - from.m11,
        .m12 = to.m12 - from.m12,
        .m13 = to.m13 - from.m13,
        .m14 = to.m14 - from.m14,
        .m21 = to.m21 - from.m21,
        .m22 = to.m22 - from.m22,
        .m23 = to.m23 - from.m23,
        .m24 = to.m24 - from.m24,
        .m31 = to.m31 - from.m31,
        .m32 = to.m32 - from.m32,
        .m33 = to.m33 - from.m33,
        .m34 = to.m34 - from.m34,
        .m41 = to.m41 - from.m41,
        .m42 = to.m42 - from.m42,
        .m43 = to.m43 - from.m43,
        .m44 = to.m44 - from.m44
    };

    RBBAnimationBlock block = ^(CGFloat elapsed, CGFloat duration) {
        CGFloat scaleFactor = interpolation(elapsed, duration);

        CATransform3D transform = {
            .m11 = from.m11 + scaleFactor * delta.m11,
            .m12 = from.m12 + scaleFactor * delta.m12,
            .m13 = from.m13 + scaleFactor * delta.m13,
            .m14 = from.m14 + scaleFactor * delta.m14,
            .m21 = from.m21 + scaleFactor * delta.m21,
            .m22 = from.m22 + scaleFactor * delta.m22,
            .m23 = from.m23 + scaleFactor * delta.m23,
            .m24 = from.m24 + scaleFactor * delta.m24,
            .m31 = from.m31 + scaleFactor * delta.m31,
            .m32 = from.m32 + scaleFactor * delta.m32,
            .m33 = from.m33 + scaleFactor * delta.m33,
            .m34 = from.m34 + scaleFactor * delta.m34,
            .m41 = from.m41 + scaleFactor * delta.m41,
            .m42 = from.m42 + scaleFactor * delta.m42,
            .m43 = from.m43 + scaleFactor * delta.m43,
            .m44 = from.m44 + scaleFactor * delta.m44
        };

        return [NSValue valueWithCATransform3D:transform];
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
