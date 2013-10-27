//
//  RBBAnimationViewController.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"
#import "CAAnimation+Name.h"

#import "RBBAnimationViewController.h"

@interface RBBAnimationViewController ()

@property (readwrite, nonatomic, strong) UIView *rectangle;

@end

@implementation RBBAnimationViewController

- (instancetype)initWithAnimation:(RBBAnimation *)animation {
    self = [super init];
    if (self == nil) return nil;

    _animation = animation;
    self.title = animation.rbb_name;

    return self;
}

#pragma mark - Properties

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

    self.animation.repeatCount = HUGE_VALF;

    [self.rectangle.layer addAnimation:self.animation forKey:@"Animation"];
}

@end
