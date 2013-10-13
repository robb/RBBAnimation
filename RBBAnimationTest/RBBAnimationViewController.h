//
//  RBBAnimationViewController.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBBAnimationViewController : UIViewController

- (instancetype)initWithAnimation:(RBBAnimation *)animation;

@property (readonly, nonatomic, strong) RBBAnimation *animation;

@end
