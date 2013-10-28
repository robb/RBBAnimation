//
//  RBBAnimationListViewController.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "CAAnimation+Name.h"
#import "RBBAnimation.h"
#import "RBBAnimationViewController.h"
#import "RBBCubicBezier.h"
#import "RBBCustomAnimation.h"
#import "RBBTweenAnimation.h"
#import "RBBSpringAnimation.h"

#import "RBBAnimationListViewController.h"

@interface RBBAnimationListViewController ()

@property (readwrite, nonatomic, copy) NSArray *animations;

@end

@implementation RBBAnimationListViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Animations";

    RBBTweenAnimation *easeInOutBack = [RBBTweenAnimation animationWithKeyPath:@"position.y"];

    easeInOutBack.fromValue = @(-100.0f);
    easeInOutBack.toValue = @(100.0f);
    easeInOutBack.easing = RBBCubicBezier(0.68, -0.55, 0.265, 1.55);

    easeInOutBack.additive = YES;
    easeInOutBack.duration = 0.6;
    easeInOutBack.rbb_name = @"ease in out back";

    RBBTweenAnimation *scale = [RBBTweenAnimation animationWithKeyPath:@"bounds"];

    scale.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    scale.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];

    scale.additive = YES;
    scale.duration = 1;
    scale.rbb_name = @"scale";

    RBBSpringAnimation *spring = [RBBSpringAnimation animationWithKeyPath:@"position.y"];

    spring.fromValue = @(-100.0f);
    spring.toValue = @(100.0f);
    spring.mass = 1;
    spring.damping = 10;
    spring.stiffness = 100;

    spring.additive = YES;
    spring.duration = [spring durationForEpsilon:0.01];
    spring.rbb_name = @"spring";

    RBBTweenAnimation *sinus = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    sinus.fromValue = @(0);
    sinus.toValue = @(100);
    sinus.easing = ^CGFloat (CGFloat fraction) {
        return sin((fraction) * 2 * M_PI);
    };

    sinus.additive = YES;
    sinus.duration = 2;
    sinus.rbb_name = @"sine wave";

    RBBTweenAnimation *bounce = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    bounce.fromValue = @(-100);
    bounce.toValue = @(100);
    bounce.easing = RBBEasingFunctionEaseOutBounce;

    bounce.additive = YES;
    bounce.duration = 0.8;
    bounce.rbb_name = @"bounce";

    RBBCustomAnimation *rainbow = [RBBCustomAnimation animationWithKeyPath:@"backgroundColor"];
    rainbow.animationBlock = ^(CGFloat elapsed, CGFloat duration) {
        return (id)[UIColor colorWithHue:elapsed / duration saturation:1 brightness:1 alpha:1].CGColor;
    };

    rainbow.duration = 5;
    rainbow.rbb_name = @"rainbow";

    self.animations = @[
        easeInOutBack,
        spring,
        scale,
        sinus,
        bounce,
        rainbow
    ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.animations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    RBBAnimation *animation = self.animations[indexPath.row];
    cell.textLabel.text = animation.rbb_name;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RBBAnimation *animation = self.animations[indexPath.row];

    RBBAnimationViewController *vc = [[RBBAnimationViewController alloc] initWithAnimation:animation];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
