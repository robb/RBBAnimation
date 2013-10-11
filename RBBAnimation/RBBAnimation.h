//
//  RBBAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/10/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef id (^RBBAnimationBlock)(CGFloat fraction);

@interface RBBAnimation : CAAnimation

+ (id)animationWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block;

- (id)initWithKeyPath:(NSString *)path block:(RBBAnimationBlock)block;

@property (readwrite, nonatomic, copy) NSString *keyPath;

@end
