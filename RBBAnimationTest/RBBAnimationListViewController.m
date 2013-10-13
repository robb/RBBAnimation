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

#import "RBBAnimationListViewController.h"

@interface RBBAnimationListViewController ()

@property (readwrite, nonatomic, copy) NSArray *animations;

@end

@implementation RBBAnimationListViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Animations";

    RBBAnimation *sinus = [RBBAnimation
        animationWithKeyPath:@"position.y"
        block:^(CGFloat fraction) {
          return @(100 * sin(fraction * 2 * M_PI));
        }];

    sinus.additive = YES;
    sinus.duration = 2;
    sinus.name = @"position.x = sin(t)";

    self.animations = @[
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
