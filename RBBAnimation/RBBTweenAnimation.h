//
//  RBBTweenAnimation.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

#import "RBBEasingFunction.h"

@interface RBBTweenAnimation : RBBAnimation

@property (readwrite, nonatomic, strong) NSValue *from;
@property (readwrite, nonatomic, strong) NSValue *to;

@property (readwrite, nonatomic, copy) RBBEasingFunction easing;

@end
