//
//  RBBAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/10/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"
#import "RBBLinearInterpolation.h"

#import "RBBAnimation.h"

@interface RBBAnimation ()

@end

@implementation RBBAnimation

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingValues {
    return [NSSet setWithArray:@[ @"animationBlock", @"duration" ]];
}

#pragma mark - CAKeyframeAnimation

- (NSArray *)values {
    RBBAnimationBlock block = [self.animationBlock copy];

    CGFloat duration = self.duration;

    return [RBBBlockBasedArray arrayWithCount:duration * 60 block:^id(NSUInteger idx) {
        return block(idx / 60.0, duration);
    }];
}

#pragma mark - Unavailable

- (void)setPath:(CGPathRef)path {
    return;
}

- (CGPathRef)path {
    return NULL;
}

- (void)setRotationMode:(NSString *)rotationMode {
    return;
}

- (NSString *)rotationMode {
    return nil;
}

- (void)setValues:(NSArray *)values {
    return;
}

@end
