//
//  RBBLinearInterpolation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/25/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>

#import "UIColor+PlatformIndependence.h"

#define RBBColor UIColor
#else
#import <AppKit/AppKit.h>

#import "NSColor+PlatformIndependence.h"

#define RBBColor NSColor
#endif

#import "NSValue+PlatformIndependence.h"

#import "RBBLinearInterpolation.h"

static RBBLinearInterpolation RBBInterpolateCATransform3D(CATransform3D from, CATransform3D to) {
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

    return ^(CGFloat fraction) {
        CATransform3D transform = {
            .m11 = from.m11 + fraction * delta.m11,
            .m12 = from.m12 + fraction * delta.m12,
            .m13 = from.m13 + fraction * delta.m13,
            .m14 = from.m14 + fraction * delta.m14,
            .m21 = from.m21 + fraction * delta.m21,
            .m22 = from.m22 + fraction * delta.m22,
            .m23 = from.m23 + fraction * delta.m23,
            .m24 = from.m24 + fraction * delta.m24,
            .m31 = from.m31 + fraction * delta.m31,
            .m32 = from.m32 + fraction * delta.m32,
            .m33 = from.m33 + fraction * delta.m33,
            .m34 = from.m34 + fraction * delta.m34,
            .m41 = from.m41 + fraction * delta.m41,
            .m42 = from.m42 + fraction * delta.m42,
            .m43 = from.m43 + fraction * delta.m43,
            .m44 = from.m44 + fraction * delta.m44
        };

        return [NSValue valueWithCATransform3D:transform];
    };
}

static RBBLinearInterpolation RBBInterpolateCGRect(CGRect from, CGRect to) {
    CGFloat deltaX = to.origin.x - from.origin.x;
    CGFloat deltaY = to.origin.y - from.origin.y;
    CGFloat deltaWidth = to.size.width - from.size.width;
    CGFloat deltaHeight = to.size.height - from.size.height;

    return ^(CGFloat fraction) {
        CGRect rect = {
            .origin.x = from.origin.x + fraction * deltaX,
            .origin.y = from.origin.y + fraction * deltaY,
            .size.width = from.size.width + fraction * deltaWidth,
            .size.height = from.size.height + fraction * deltaHeight
        };

        return [NSValue rbb_valueWithCGRect:rect];
    };
}

static RBBLinearInterpolation RBBInterpolateCGPoint(CGPoint from, CGPoint to) {
    CGFloat deltaX = to.x - from.x;
    CGFloat deltaY = to.y - from.y;

    return ^(CGFloat fraction) {
        CGPoint point = {
            .x = from.x + fraction * deltaX,
            .y = from.y + fraction * deltaY,
        };

        return [NSValue rbb_valueWithCGPoint:point];
    };
}

static RBBLinearInterpolation RBBInterpolateCGSize(CGSize from, CGSize to) {
    CGFloat deltaWidth = to.width - from.width;
    CGFloat deltaHeight = to.height - from.height;

    return ^(CGFloat fraction) {
        CGSize size = {
            .width = from.width + fraction * deltaWidth,
            .height = from.height + fraction * deltaHeight,
        };

        return [NSValue rbb_valueWithCGSize:size];
    };
}

static RBBLinearInterpolation RBBInterpolateCGFloat(CGFloat from, CGFloat to) {
    CGFloat delta = to - from;

    return ^(CGFloat fraction) {
        return @(from + fraction * delta);
    };
};

// TODO: Color spaces can present a problem.
//
// For example, if [UIColor/NSColor whiteColor] is used, the color space is
// white, and this fails.
//
// A comprehensive conversion process should always bring the colors into an
// HSBA-compatible color space. In the mean time, always create colors using
// +olorWithHue:saturation:brightness:alpha: method.
static RBBLinearInterpolation RBBInterpolateColor(RBBColor *from, RBBColor *to) {
    CGFloat fromHue = 0.0f;
    CGFloat fromSaturation = 0.0f;
    CGFloat fromBrightness = 0.0f;
    CGFloat fromAlpha = 0.0f;

    [from getHue:&fromHue saturation:&fromSaturation brightness:&fromBrightness alpha:&fromAlpha];

    CGFloat toHue = 0.0f;
    CGFloat toSaturation = 0.0f;
    CGFloat toBrightness = 0.0f;
    CGFloat toAlpha = 0.0f;

    [to getHue:&toHue saturation:&toSaturation brightness:&toBrightness alpha:&toAlpha];

    CGFloat deltaHue = toHue - fromHue;
    CGFloat deltaSaturation = toSaturation - fromSaturation;
    CGFloat deltaBrightness = toBrightness - fromBrightness;
    CGFloat deltaAlpha = toAlpha - fromAlpha;

    return ^(CGFloat fraction) {
        CGFloat hue = fromHue + fraction * deltaHue;
        CGFloat saturation = fromSaturation + fraction * deltaSaturation;
        CGFloat brightness = fromBrightness + fraction * deltaBrightness;
        CGFloat alpha = fromAlpha + fraction * deltaAlpha;

        CGColorRef colorRef = [RBBColor rbb_colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha].CGColor;

        return (__bridge id)colorRef;
    };
}

extern RBBLinearInterpolation RBBInterpolate(id from, id to) {
    if ([from isKindOfClass:NSNumber.class] && [to isKindOfClass:NSNumber.class]) {
        #if CGFLOAT_IS_DOUBLE
        return RBBInterpolateCGFloat([(NSNumber *)from doubleValue], [(NSNumber *)to doubleValue]);
        #else
        return RBBInterpolateCGFloat([(NSNumber *)from floatValue], [(NSNumber *)to doubleValue]);
        #endif
    }

    if ((CFGetTypeID((__bridge CFTypeRef)from) == CGColorGetTypeID()) && (CFGetTypeID((__bridge CFTypeRef)to) == CGColorGetTypeID())) {
        RBBColor *fromColor = [RBBColor colorWithCGColor:(CGColorRef)from];
        RBBColor *toColor = [RBBColor colorWithCGColor:(CGColorRef)to];

        return RBBInterpolateColor(fromColor, toColor);
    }

    if (([from isKindOfClass:NSValue.class] && [to isKindOfClass:NSValue.class]) && strcmp([from objCType], [to objCType]) == 0) {
        if (strcmp([from objCType], @encode(CATransform3D)) == 0) {
            return RBBInterpolateCATransform3D([from CATransform3DValue], [to CATransform3DValue]);
        }

        if (strcmp([from objCType], @encode(CGRect)) == 0) {
            return RBBInterpolateCGRect([from rbb_CGRectValue], [to rbb_CGRectValue]);
        }

        if (strcmp([from objCType], @encode(CGPoint)) == 0) {
            return RBBInterpolateCGPoint([from rbb_CGPointValue ], [to rbb_CGPointValue]);
        }

        if (strcmp([from objCType], @encode(CGSize)) == 0) {
            return RBBInterpolateCGSize([from rbb_CGSizeValue], [to rbb_CGSizeValue]);
        }
    }

    return ^(CGFloat fraction) {
        return fraction < 0.5 ? from : to;
    };
}
