//
//  RBBRubberbandAnimationSpec.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RBBSpringAnimation.h"

#import "RBBRubberbandAnimation.h"

SpecBegin(RBBRubberbandAnimation)

it(@"should initialize", ^{
    expect([RBBRubberbandAnimation animation]).notTo.beNil();

    expect([RBBRubberbandAnimation animationWithKeyPath:@"position"]).notTo.beNil();
});

it(@"should behave like RBBSpringAnimations if v is 0", ^{
    RBBSpringAnimation *spring = [RBBSpringAnimation animationWithKeyPath:@"position"];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    spring.velocity = 0;

    RBBRubberbandAnimation *rubberband = [RBBRubberbandAnimation animationWithKeyPath:@"position"];
    rubberband.from = CGPointMake(100, 200);
    rubberband.to = CGPointMake(300, 400);
    rubberband.velocity = CGPointZero;

    expect(rubberband.values).to.equal(spring.values);
});

it(@"should take the velocity into account even if ∆x and ∆y are 0", ^{
    RBBRubberbandAnimation *animation = [RBBRubberbandAnimation animationWithKeyPath:@"position"];
    animation.from = CGPointZero;
    animation.to = CGPointZero;
    animation.velocity = CGPointMake(500, 0);
    animation.duration = 1;

    CGFloat maxX = -HUGE_VALF;

    for (NSValue *value in animation.values) {
        if (value.CGPointValue.x > maxX) maxX = value.CGPointValue.x;
    }

    expect(maxX).to.beCloseToWithin(27, 0.5);
});

SpecEnd
