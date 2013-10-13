//
//  RBBTweenAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

typedef CGFloat (^RBBEasingFunction)(CGFloat fraction);

extern RBBEasingFunction const RBBEasingFunctionLinear;

@interface RBBTweenAnimation : RBBAnimation

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to block:(RBBEasingFunction)easingFunction;

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGFloat:(CGFloat)from toCGFloat:(CGFloat)to block:(RBBEasingFunction)easingFunction;
+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGRect:(CGRect)from toCGRect:(CGRect)to block:(RBBEasingFunction)easingFunction;

@property (readonly, nonatomic, strong) NSValue *fromValue;
@property (readonly, nonatomic, strong) NSValue *toValue;

@end