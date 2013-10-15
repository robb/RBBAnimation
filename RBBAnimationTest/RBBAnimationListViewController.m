//
//  RBBAnimationListViewController.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBAnimation.h"
#import "RBBAnimation+Name.h"
#import "RBBAnimationViewController.h"
#import "RBBCubicBezier.h"
#import "RBBTweenAnimation.h"

#import "RBBAnimationListViewController.h"

@interface RBBAnimationListViewController ()

@property (readwrite, nonatomic, copy) NSArray *animations;

@end

@implementation RBBAnimationListViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Animations";

    RBBAnimation *easeInOutBack = [RBBTweenAnimation
        tweenWithKeyPath:@"position.y"
        from:@(-100.0f)
        to:@(100.0f)
        easingFunction:RBBCubicBezier(0.68, -0.55, 0.265, 1.55)];

    easeInOutBack.additive = YES;
    easeInOutBack.duration = 0.6;
    easeInOutBack.name = @"ease in out back";

    RBBAnimation *scale = [RBBTweenAnimation
        tweenWithKeyPath:@"bounds"
        from:[NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)]
        to:[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]];

    scale.additive = YES;
    scale.duration = 1;
    scale.name = @"scale";

    RBBAnimation *sinus = [RBBAnimation
        animationWithKeyPath:@"position.y"
        block:^(CGFloat elapsed, CGFloat duration) {
            return @(100 * sin((elapsed / duration) * 2 * M_PI));
        }];

    sinus.additive = YES;
    sinus.duration = 2;
    sinus.name = @"sine wave";

    self.animations = @[
        easeInOutBack,
        scale,
        sinus
    ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.animations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    RBBAnimation *animation = self.animations[indexPath.row];
    cell.textLabel.text = animation.name;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RBBAnimation *animation = self.animations[indexPath.row];

    RBBAnimationViewController *vc = [[RBBAnimationViewController alloc] initWithAnimation:animation];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
