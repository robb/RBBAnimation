//
//  RBBCustomAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/27/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBCustomAnimation.h"

@implementation RBBCustomAnimation

@synthesize animationBlock = _animationBlock;

#pragma mark - NSObject

- (id)copyWithZone:(NSZone *)zone {
    RBBCustomAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;

    copy->_animationBlock = [_animationBlock copy];

    return copy;
}

@end
