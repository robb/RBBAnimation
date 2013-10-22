//
//  RBBAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/10/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"

#import "RBBAnimation.h"

@interface RBBAnimation ()

@property (readonly, nonatomic, copy) RBBAnimationBlock block;
@property (readonly, nonatomic, assign) CGFloat frameCount;
@property (readonly, nonatomic, assign) CGFloat frameRate;

@end

@implementation RBBAnimation

#pragma mark - Lifecycle

+ (id)animationWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    return [[self alloc] initWithKeyPath:path block:block];
}

- (id)initWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    NSParameterAssert(path != nil);
    NSParameterAssert(block != nil);

    self = [super init];
    if (self == nil) return nil;

    _block = [block copy];

    self.keyPath = path;

    return self;
}

#pragma mark - Properties

- (CGFloat)frameCount {
    return self.duration * self.frameRate;
}

- (CGFloat)frameRate {
    return 60;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    RBBAnimation *copy = [super copyWithZone:zone];
    if (copy == nil) return nil;

    copy->_block = [_block copy];

    return copy;
}

#pragma mark - CAAnimation

- (void)setDuration:(CFTimeInterval)duration {
    [super setDuration:duration];

    RBBAnimationBlock block = self.block;
    CGFloat frameRate = self.frameRate;

    self.values = [RBBBlockBasedArray arrayWithCount:self.frameCount block:^(NSUInteger idx) {
        return block(idx / frameRate, duration);
    }];
}

@end
