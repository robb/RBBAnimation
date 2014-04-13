//
//  NSValue+PlatformIndependence.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 11/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIKit.h>
#endif

#import "NSValue+PlatformIndependence.h"

@implementation NSValue (PlatformIndependence)

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
+ (instancetype)rbb_valueWithCGRect:(CGRect)rect {
    return [self valueWithCGRect:rect];
}

+ (instancetype)rbb_valueWithCGSize:(CGSize)size {
    return [self valueWithCGSize:size];
}

+ (instancetype)rbb_valueWithCGPoint:(CGPoint)point {
    return [self valueWithCGPoint:point];
}

- (CGRect)rbb_CGRectValue {
    return [self CGRectValue];
}

- (CGSize)rbb_CGSizeValue {
    return [self CGSizeValue];
}

- (CGPoint)rbb_CGPointValue {
    return [self CGPointValue];
}
#elif TARGET_OS_MAC
+ (instancetype)rbb_valueWithCGRect:(CGRect)rect {
    return [self valueWithRect:rect];
}

+ (instancetype)rbb_valueWithCGSize:(CGSize)size {
    return [self valueWithSize:size];
}

+ (instancetype)rbb_valueWithCGPoint:(CGPoint)point {
    return [self valueWithPoint:point];
}

- (CGRect)rbb_CGRectValue {
    return [self rectValue];
}

- (CGSize)rbb_CGSizeValue {
    return [self sizeValue];
}

- (CGPoint)rbb_CGPointValue {
    return [self pointValue];
}
#endif

@end
