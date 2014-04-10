//
//  RBBSpringAnimationSpec.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "RBBSpringAnimation.h"

@interface CALayer (Private)

// Here be dragons
- (CALayer *)layerAtTime:(NSTimeInterval)time;

@end

SpecBegin(RBBSpringAnimation)

it(@"should initialize", ^{
    expect([RBBSpringAnimation animation]).notTo.beNil();

    expect([RBBSpringAnimation animationWithKeyPath:@"position"]).notTo.beNil();
});

it(@"should default to not allow overdamping", ^{
    RBBSpringAnimation *animation = [RBBSpringAnimation animation];

    expect(animation.allowsOverdamping).to.beFalsy();
});

describe(@"compared to CASpringAnimation", ^{
    __block RBBSpringAnimation *RBBSpring, *CASpring;

    beforeEach(^{
        RBBSpring = [RBBSpringAnimation animation];
        expect(RBBSpring).toNot.beNil();

        CASpring = [NSClassFromString(@"CASpringAnimation") animation];
        expect(CASpring).toNot.beNil();
    });

    it(@"should have the same default values", ^{
        expect(RBBSpring.damping).to.equal(CASpring.damping);
        expect(RBBSpring.mass).to.equal(CASpring.mass);
        expect(RBBSpring.stiffness).to.equal(CASpring.stiffness);
        expect(RBBSpring.velocity).to.equal(CASpring.velocity);
    });

    describe(@"when run on a layer", ^{
        __block CALayer *a, *b;

        beforeEach(^{
            for (RBBSpringAnimation *animation in @[ RBBSpring, CASpring ]) {
                animation.keyPath = @"position.x";
                animation.velocity = 5;
                animation.fromValue = @100;
                animation.toValue = @200;

                animation.duration = 1;
                animation.beginTime = 0;
            }

            a = [CALayer layer];
            b = [CALayer layer];

            a.speed = 0;
            b.speed = 0;

            [a addAnimation:RBBSpring forKey:@"spring"];
            [b addAnimation:CASpring forKey:@"spring"];
        });

        it(@"should have similar values to CASpringAnimation", ^{
            for (NSUInteger frame = 0; frame < 60; frame++) {
                CGFloat value = [a layerAtTime:a.beginTime + frame / 60.0].position.x;
                CGFloat expected = [b layerAtTime:b.beginTime + frame / 60.0].position.x;

                expect(value).to.beCloseToWithin(expected, 0.001);
            }
        });
    });
});

SpecEnd
