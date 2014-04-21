//
//  RBBLinearInterpolationSpec.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 11/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>

#import "UIColor+PlatformIndependence.h"

#define SpecsColor UIColor
#else
#import <AppKit/AppKit.h>

#import "NSColor+PlatformIndependence.h"

#define SpecsColor NSColor
#endif

#import "NSValue+PlatformIndependence.h"

#import "RBBLinearInterpolation.h"

SpecBegin(RBBLinearInterpolation)

__block RBBLinearInterpolation lerp;

describe(@"Interpolating numbers", ^{
    it(@"should interpolate them as floats", ^{
        lerp = RBBInterpolate(@2, @4);

        expect(lerp(0.5)).to.beCloseToWithin(3, 0.01);
    });
});

describe(@"Interpolating colors", ^{
    it(@"should interpolate HSBA components separately", ^{
        CGColorRef from = [SpecsColor rbb_colorWithHue:0.2 saturation:0.3 brightness:0.4 alpha:0.5].CGColor;
        CGColorRef to = [SpecsColor rbb_colorWithHue:0.4 saturation:0.5 brightness:0.6 alpha:0.7].CGColor;

        lerp = RBBInterpolate((__bridge id)from, (__bridge id)to);

        CGFloat hue, saturation, brightness, alpha;

        SpecsColor *color = [SpecsColor colorWithCGColor:(__bridge CGColorRef)lerp(0.5)];
        [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

        expect(hue).to.beCloseToWithin(0.3, 0.01);
        expect(saturation).to.beCloseToWithin(0.4, 0.01);
        expect(brightness).to.beCloseToWithin(0.5, 0.01);
        expect(alpha).to.beCloseToWithin(0.6, 0.01);
    });
});

describe(@"Interpolating CATransform3D", ^{
    it(@"should interpolate every entry separately", ^{
        CATransform3D from = {
             1,  2,  3,  4,
             5,  6,  7,  8,
             9, 10, 11, 12,
            13, 14, 15, 16
        };

        CATransform3D to = {
             3,  4,  5,  6,
             7,  8,  9, 10,
            11, 12, 13, 14,
            15, 16, 17, 18
        };

        lerp = RBBInterpolate([NSValue valueWithCATransform3D:from], [NSValue valueWithCATransform3D:to]);

        CATransform3D transform = [lerp(0.5) CATransform3DValue];

        expect(transform.m11).to.beCloseToWithin( 2, 0.01);
        expect(transform.m12).to.beCloseToWithin( 3, 0.01);
        expect(transform.m13).to.beCloseToWithin( 4, 0.01);
        expect(transform.m14).to.beCloseToWithin( 5, 0.01);
        expect(transform.m21).to.beCloseToWithin( 6, 0.01);
        expect(transform.m22).to.beCloseToWithin( 7, 0.01);
        expect(transform.m23).to.beCloseToWithin( 8, 0.01);
        expect(transform.m24).to.beCloseToWithin( 9, 0.01);
        expect(transform.m31).to.beCloseToWithin(10, 0.01);
        expect(transform.m32).to.beCloseToWithin(11, 0.01);
        expect(transform.m33).to.beCloseToWithin(12, 0.01);
        expect(transform.m34).to.beCloseToWithin(13, 0.01);
        expect(transform.m41).to.beCloseToWithin(14, 0.01);
        expect(transform.m42).to.beCloseToWithin(15, 0.01);
        expect(transform.m43).to.beCloseToWithin(16, 0.01);
        expect(transform.m44).to.beCloseToWithin(17, 0.01);
    });
});

describe(@"Interpolating CGRects", ^{
    it(@"should should interpolate size and origin separately", ^{
        CGRect from = CGRectMake(1, 2, 3, 4);
        CGRect to = CGRectMake(5, 6, 7, 8);

        lerp = RBBInterpolate([NSValue rbb_valueWithCGRect:from], [NSValue rbb_valueWithCGRect:to]);

        expect(lerp(0.5)).to.equal([NSValue rbb_valueWithCGRect:CGRectMake(3, 4, 5, 6)]);
    });
});

describe(@"Interpolating CGPoints", ^{
    it(@"should should interpolate x and y", ^{
        CGPoint from = CGPointMake(1, 2);
        CGPoint to = CGPointMake(5, 6);

        lerp = RBBInterpolate([NSValue rbb_valueWithCGPoint:from], [NSValue rbb_valueWithCGPoint:to]);

        expect(lerp(0.5)).to.equal([NSValue rbb_valueWithCGPoint:CGPointMake(3, 4)]);
    });
});

describe(@"Interpolating CGSizes", ^{
    it(@"should should interpolate x and y", ^{
        CGSize from = CGSizeMake(1, 2);
        CGSize to = CGSizeMake(5, 6);

        lerp = RBBInterpolate([NSValue rbb_valueWithCGSize:from], [NSValue rbb_valueWithCGSize:to]);

        expect(lerp(0.5)).to.equal([NSValue rbb_valueWithCGSize:CGSizeMake(3, 4)]);
    });
});

describe(@"Interpolating mismatched value types", ^{
    it(@"should change between both input values", ^{
        NSValue *from = [NSValue rbb_valueWithCGPoint:CGPointMake(1, 2)];
        NSValue *to = [NSValue rbb_valueWithCGRect:CGRectMake(5, 6, 7, 8)];

        lerp = RBBInterpolate(from, to);

        expect(lerp(0.25)).to.equal(from);
        expect(lerp(0.75)).to.equal(to);
    });
});

describe(@"Interpolating anything else", ^{
    it(@"should change between both input values", ^{
        lerp = RBBInterpolate(@"foo", @"bar");

        expect(lerp(0.25)).to.equal(@"foo");
        expect(lerp(0.75)).to.equal(@"bar");
    });
});

SpecEnd
