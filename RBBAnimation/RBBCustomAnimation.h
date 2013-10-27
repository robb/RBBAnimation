//
//  RBBCustomAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/27/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

@interface RBBCustomAnimation : RBBAnimation

@property (readwrite, nonatomic, copy) RBBAnimationBlock animationBlock;

@end
