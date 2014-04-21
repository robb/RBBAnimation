//
//  NSValue+PlatformIndependence.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 11/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue (PlatformIndependence)

+ (instancetype)rbb_valueWithCGRect:(CGRect)rect;
+ (instancetype)rbb_valueWithCGSize:(CGSize)size;
+ (instancetype)rbb_valueWithCGPoint:(CGPoint)point;

- (CGRect)rbb_CGRectValue;
- (CGSize)rbb_CGSizeValue;
- (CGPoint)rbb_CGPointValue;

@end
