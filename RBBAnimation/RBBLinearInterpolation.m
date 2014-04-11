//
//  RBBLinearInterpolation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/25/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBLinearInterpolation.h"

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import <UIKit/UIKit.h>
#define VALUE_FOR_RECT(rect) [NSValue valueWithCGRect:rect]
#define RECT_VALUE(value) [value CGRectValue]
#define VALUE_FOR_SIZE(size) [NSValue valueWithCGSize:size]
#define SIZE_VALUE(value) [value CGSizeValue]
#define VALUE_FOR_POINT(point) [NSValue valueWithCGPoint:point]
#define POINT_VALUE(value) [value CGPointValue]

#elif TARGET_OS_MAC

#define VALUE_FOR_RECT(rect) [NSValue valueWithRect:rect]
#define RECT_VALUE(value) [value rectValue]
#define VALUE_FOR_SIZE(size) [NSValue valueWithSize:size]
#define SIZE_VALUE(value) [value sizeValue]
#define VALUE_FOR_POINT(point) [NSValue valueWithPoint:point]
#define POINT_VALUE(value) [value pointValue]

#endif

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

        return VALUE_FOR_RECT(rect);
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

        return VALUE_FOR_POINT(point);
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

        return VALUE_FOR_SIZE(size);
    };
}

static RBBLinearInterpolation RBBInterpolateCGFloat(CGFloat from, CGFloat to) {
    CGFloat delta = to - from;

    return ^(CGFloat fraction) {
        return @(from + fraction * delta);
    };
};

static void RBBGetHSBAFromColor(id color, CGFloat *hue, CGFloat *saturation, CGFloat *brightness, CGFloat *alpha) {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    [(UIColor *)color getHue:hue saturation:saturation brightness:brightness alpha:alpha];
#elif TARGET_OS_MAC
    [(NSColor *)color getHue:hue saturation:saturation brightness:brightness alpha:alpha];
#endif
};

static CGColorRef RBBColorRefWithHSBA(CGFloat hue, CGFloat saturation, CGFloat brightness, CGFloat alpha) {
    CGColorRef colorRef = NULL;
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    colorRef = [[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] CGColor];
#elif TARGET_OS_MAC
    colorRef = [[NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha] CGColor];
#endif
    return colorRef;
}

static RBBLinearInterpolation RBBInterpolateColor(id from, id to) {
    CGFloat fromHue = 0.0f;
    CGFloat toHue = 0.0f;
    
    CGFloat fromSaturation = 0.0f;
    CGFloat toSaturation = 0.0f;
    
    CGFloat fromBrightness = 0.0f;
    CGFloat toBrightness = 0.0f;
    
    CGFloat fromAlpha = 0.0f;
    CGFloat toAlpha = 0.0f;
    
    // TODO: Color spaces can present a problem. For example, if [UIColor/NSColor whiteColor] is used, the color space is white, and this fails.
    // A comprehensive conversion process should always bring the colors into an HSB-compatible color space. In the mean time, always
    // create colors using the [UIColor/NSColor colorWithHue:saturation:brightness:alpha:] method. :-\
    
    RBBGetHSBAFromColor(from, &fromHue, &fromSaturation, &fromBrightness, &fromAlpha);
    RBBGetHSBAFromColor(to, &toHue, &toSaturation, &toBrightness, &toAlpha);
    
    CGFloat deltaHue = toHue - fromHue;
    CGFloat deltaSaturation = toSaturation - fromSaturation;
    CGFloat deltaBrightness = toBrightness - fromBrightness;
    CGFloat deltaAlpha = toAlpha - fromAlpha;
    
    return ^(CGFloat fraction) {
        CGFloat interpolatedHue = fromHue + fraction * deltaHue;
        CGFloat interpolatedSaturation = fromSaturation + fraction * deltaSaturation;
        CGFloat interpolatedBrightness = fromBrightness + fraction * deltaBrightness;
        CGFloat interpolatedAlpha = fromAlpha + fraction * deltaAlpha;
        
        CGColorRef colorRef = RBBColorRefWithHSBA(interpolatedHue, interpolatedSaturation, interpolatedBrightness, interpolatedAlpha);
        
        return (__bridge id)colorRef;
    };
}

extern RBBLinearInterpolation RBBInterpolate(NSValue *from, NSValue *to) {
    BOOL valuesAreNumbers = ([from isKindOfClass:NSNumber.class] && [to isKindOfClass:NSNumber.class]);
    BOOL valuesAreColorRefs = ((CFGetTypeID((CFTypeRef)from) == CGColorGetTypeID()) && (CFGetTypeID((CFTypeRef)to) == CGColorGetTypeID()));
    
    NSCParameterAssert(valuesAreNumbers || valuesAreColorRefs || strcmp(from.objCType, to.objCType) == 0);
    
    if (valuesAreNumbers) {
        #if CGFLOAT_IS_DOUBLE
        return RBBInterpolateCGFloat([(NSNumber *)from doubleValue], [(NSNumber *)to doubleValue]);
        #else
        return RBBInterpolateCGFloat([(NSNumber *)from floatValue], [(NSNumber *)to doubleValue]);
        #endif
    }
    
    if (valuesAreColorRefs) {
        id fromColor = nil;
        id toColor = nil;
        
        #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        fromColor = [UIColor colorWithCGColor:(CGColorRef)from];
        toColor = [UIColor colorWithCGColor:(CGColorRef)to];
        #elif TARGET_OS_MAC
        fromColor = [NSColor colorWithCGColor:(CGColorRef)from];
        toColor = [NSColor colorWithCGColor:(CGColorRef)to];
        #endif
        
        return RBBInterpolateColor(fromColor, toColor);
    }

    if (strcmp(from.objCType, @encode(CATransform3D)) == 0) {
        return RBBInterpolateCATransform3D(from.CATransform3DValue, to.CATransform3DValue);
    }

    if (strcmp(from.objCType, @encode(CGRect)) == 0) {
        return RBBInterpolateCGRect(RECT_VALUE(from), RECT_VALUE(to));
    }

    if (strcmp(from.objCType, @encode(CGPoint)) == 0) {
        return RBBInterpolateCGPoint(POINT_VALUE(from), POINT_VALUE(to));
    }

    if (strcmp(from.objCType, @encode(CGSize)) == 0) {
        return RBBInterpolateCGSize(SIZE_VALUE(from), SIZE_VALUE(to));
    }

    return ^(CGFloat fraction) {
        return fraction < 0.5 ? from : to;
    };
}
