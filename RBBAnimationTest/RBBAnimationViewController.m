//
//  RBBAnimationViewController.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"

#import "RBBAnimationViewController.h"

@interface RBBAnimationViewController ()

@property (readwrite, nonatomic, strong) UIView *rectangle;

@end

@implementation RBBAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;

    self.rectangle = [[UIView alloc] init];
    self.rectangle.backgroundColor = UIColor.redColor;
    self.rectangle.bounds = CGRectMake(0, 0, 100, 100);
    self.rectangle.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                        CGRectGetMidY(self.view.frame));

    [self.view addSubview:self.rectangle];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    RBBAnimation *animation = [RBBAnimation
        animationWithKeyPath:@"position.y"
        block:^(CGFloat fraction) {
            return @(CGRectGetMidY(self.view.frame) - 200 * sin(fraction * 2 * M_PI));
        }];

    animation.duration = 2;
    animation.repeatCount = HUGE_VALF;

    [self.rectangle.layer addAnimation:animation forKey:@"animation"];
}

@end
