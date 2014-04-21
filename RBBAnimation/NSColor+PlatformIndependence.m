//
//  NSColor+PlatformIndependence.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 11/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "NSColor+PlatformIndependence.h"

@implementation NSColor (PlatformIndependence)

+ (instancetype)rbb_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    return [self colorWithDeviceHue:hue saturation:saturation brightness:brightness alpha:alpha];;
}

@end
