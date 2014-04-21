//
//  NSColor+PlatformIndependence.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 11/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (PlatformIndependence)

+ (instancetype)rbb_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

@end
