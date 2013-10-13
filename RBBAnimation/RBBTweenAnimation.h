//
//  RBBTweenAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

typedef CGFloat (^RBBTweenAnimationBlock)(CGFloat fraction);

extern RBBTweenAnimationBlock const RBBLinearTweenAnimation;

@interface RBBTweenAnimation : RBBAnimation

+ (id)tweenWithKeyPath:(NSString *)keyPath from:(NSValue *)from to:(NSValue *)to block:(RBBTweenAnimationBlock)tween;

+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGFloat:(CGFloat)from toCGFloat:(CGFloat)to block:(RBBTweenAnimationBlock)tween;
+ (id)tweenWithKeyPath:(NSString *)keyPath fromCGRect:(CGRect)from toCGRect:(CGRect)to block:(RBBTweenAnimationBlock)tween;

@property (readonly, nonatomic, strong) NSValue *fromValue;
@property (readonly, nonatomic, strong) NSValue *toValue;

@end