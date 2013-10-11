//
//  RBBAnimation.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/10/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"

#import "RBBAnimation.h"

@interface RBBKeyframeAnimation : CAKeyframeAnimation

+ (id)animationWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block;

@property (readonly, nonatomic, copy) RBBAnimationBlock block;
@property (readonly, nonatomic, assign) CGFloat frameCount;

@end

@implementation RBBKeyframeAnimation

#pragma mark - Lifecycle

+ (id)animationWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    return [[self alloc] initWithKeyPath:path block:block];
}

- (id)initWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    self = [super init];
    if (self == nil) return nil;

    _block = [block copy];

    self.keyPath = path;

    return self;
}

#pragma mark - Properties

- (CGFloat)frameCount {
    return self.duration * 60;
}

#pragma mark - CAAnimation

- (void)setDuration:(CFTimeInterval)duration {
    [super setDuration:duration];

    __weak typeof(self) weakSelf = self;
    self.values = [RBBBlockBasedArray arrayWithCount:self.frameCount block:^(NSUInteger idx) {
        return weakSelf.block(idx / weakSelf.frameCount);
    }];
}

@end

@implementation RBBAnimation

+ (id)animation {
    return [RBBKeyframeAnimation animation];
}

+ (id)animationWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    return [RBBKeyframeAnimation animationWithKeyPath:path block:block];
}

- (id)init {
    return (RBBAnimation *)[[RBBKeyframeAnimation alloc] init];
}

- (id)initWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block {
    return (RBBAnimation *)[RBBKeyframeAnimation animationWithKeyPath:path block:block];
}

@end
