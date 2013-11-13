//
//  AppDelegate.m
//  RBBAnimationMacTest
//
//  Created by Paulo Andrade on 13/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "AppDelegate.h"
#import "RBBAnimation.h"
#import "RBBCubicBezier.h"
#import "RBBCustomAnimation.h"
#import "RBBTweenAnimation.h"
#import "RBBSpringAnimation.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    self.redView.layer.backgroundColor = [NSColor redColor].CGColor;
    
    RBBTweenAnimation *easeInOutBack = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    
    easeInOutBack.fromValue = @(-100.0f);
    easeInOutBack.toValue = @(100.0f);
    easeInOutBack.easing = RBBCubicBezier(0.68, -0.55, 0.265, 1.55);
    
    easeInOutBack.additive = YES;
    easeInOutBack.duration = 0.6;
    [easeInOutBack setValue:@"ease in out back" forKey:@"name"];
    
    RBBTweenAnimation *scale = [RBBTweenAnimation animationWithKeyPath:@"bounds"];
    
    scale.fromValue = [NSValue valueWithRect:CGRectMake(0, 0, 0, 0)];
    scale.toValue = [NSValue valueWithRect:CGRectMake(0, 0, 100, 100)];
    
    scale.additive = YES;
    scale.duration = 1;
    [scale setValue:@"scale" forKey:@"name"];
    
    RBBSpringAnimation *spring = [RBBSpringAnimation animationWithKeyPath:@"position.y"];
    
    spring.fromValue = @(-100.0f);
    spring.toValue = @(100.0f);
    spring.mass = 1;
    spring.damping = 10;
    spring.stiffness = 100;
    
    spring.additive = YES;
    spring.duration = [spring durationForEpsilon:0.01];
    [spring setValue:@"spring" forKey:@"name"];
    
    RBBTweenAnimation *sinus = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    sinus.fromValue = @(0);
    sinus.toValue = @(100);
    sinus.easing = ^CGFloat (CGFloat fraction) {
        return sin((fraction) * 2 * M_PI);
    };
    
    sinus.additive = YES;
    sinus.duration = 2;
    [sinus setValue:@"sine wave" forKey:@"name"];
    
    RBBTweenAnimation *bounce = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    bounce.fromValue = @(-100);
    bounce.toValue = @(100);
    bounce.easing = RBBEasingFunctionEaseOutBounce;
    
    bounce.additive = YES;
    bounce.duration = 0.8;
    [bounce setValue:@"bounce" forKey:@"name"];
    
    RBBCustomAnimation *rainbow = [RBBCustomAnimation animationWithKeyPath:@"backgroundColor"];
    rainbow.animationBlock = ^(CGFloat elapsed, CGFloat duration) {
        return (id)[NSColor colorWithHue:elapsed / duration saturation:1 brightness:1 alpha:1].CGColor;
    };
    
    rainbow.duration = 5;
    [rainbow setValue:@"rainbow" forKey:@"name"];
    
    self.animations = @[
                        easeInOutBack,
                        spring,
                        scale,
                        sinus,
                        bounce,
                        rainbow
                        ];
    
    [self.animationsPopUp removeAllItems];
    [self.animationsPopUp addItemsWithTitles:[self.animations valueForKey:@"name"]];
    
    [self useAnimation:easeInOutBack];
}

- (void)useAnimation:(CAAnimation *)animation
{
    [self.redView.layer removeAnimationForKey:@"currentAnimation"];
    animation.repeatCount = HUGE_VALF;
    
    [self.redView.layer addAnimation:animation forKey:@"currentAnimation"];
}

- (IBAction)popUpValueChanged:(id)sender {
    [self useAnimation:self.animations[[sender indexOfSelectedItem]]];
}
@end
