# RBBAnimation

`RBBAnimation` is a subclass of `CAKeyframeAnimation` that allows you to
declare your __animations using blocks__ instead of writing out all the
individual key-frames.

This gives you greater flexibility when specifying your animations while keeping
your code concise.

It comes out of the box with a [replacement for
CASpringAnimation](#rbbspringanimation), [support for custom easing functions
such as bouncing](#rbbtweenanimation) as well as hooks to allow your writing
your [own animations fully from scratch](#rbbcustomanimation).

## Installation

To install RBBAnimation, I recommend the excellent [CocoaPods]. Simply add this
to your Podfile

```ruby
pod 'RBBAnimation', '0.3.0'
```

and you are ready to go!

If you'd like to run the bundled test app, make sure to install its dependencies
by running

```sh
pod install
```

after cloning the repo.

## RBBCustomAnimation

Use `RBBCustomAnimation` to create arbitrary animations by passing in an
`RBBAnimationBlock`:

<p align="center">
    <img src="http://robb.is/img/rbbanimation/rainbow.gif" alt="Rainbow" title="RBBCustomAnimation">
</p>

```objc
RBBCustomAnimation *rainbow = [RBBCustomAnimation animationWithKeyPath:@"backgroundColor"];

rainbow.animationBlock = ^(CGFloat elapsed, CGFloat duration) {
    UIColor *color = [UIColor colorWithHue:elapsed / duration
                                saturation:1
                                brightness:1
                                     alpha:1];

    return (id)color.CGColor;
};
```

The arguments of the block are the current position of the animation as well as
its total duration.

Most of the time, you will probably want to use the higher-level
`RBBTweenAnimation`.

## RBBSpringAnimation

`RBBSpringAnimation` is a handy replacement for the private [CASpringAnimation].
Specify your spring's mass, damping, stiffness as well as its initial velocity
and watch it go:

<p align="center">
    <img src="http://robb.is/img/rbbanimation/spring.gif" alt="Bouncing" title="RBBSpringAnimation">
</p>

```objc
RBBSpringAnimation *spring = [RBBSpringAnimation animationWithKeyPath:@"position.y"];

spring.fromValue = @(-100.0f);
spring.toValue = @(100.0f);
spring.velocity = 0;
spring.mass = 1;
spring.damping = 10;
spring.stiffness = 100;

spring.additive = YES;
spring.duration = [spring durationForEpsilon:0.01];
```

## RBBTweenAnimation

`RBBTweenAnimation` allows you to animate from one value to another, similar to
`CABasicAnimation` but with a greater flexibility in how the values should be
interpolated.

It supports the same cubic Bezier interpolation that you get from
`CAMediaTimingFunction` using the `RBBCubicBezier` helper function:

<p align="center">
    <img src="http://robb.is/img/rbbanimation/ease-in-out-back.gif" alt="Ease In Out Back" title="RBBCubicBezier(0.68, -0.55, 0.265, 1.55)">
</p>

```objc
RBBTweenAnimation *easeInOutBack = [RBBTweenAnimation animationWithKeyPath:@"position.y"];

easeInOutBack.fromValue = @(-100.0f);
easeInOutBack.toValue = @(100.0f);
easeInOutBack.easing = RBBCubicBezier(0.68, -0.55, 0.265, 1.55);

easeInOutBack.additive = YES;
easeInOutBack.duration = 0.6;
```

However, `RBBTweenAnimation` also supports more complex easing functions such as
`RBBEasingFunctionEaseOutBounce`:

<p align="center">
    <img src="http://robb.is/img/rbbanimation/bounce.gif" alt="Bouncing" title="RBBEasingFunctionEaseOutBounce">
</p>

```objc
RBBTweenAnimation *bounce = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
bounce.fromValue = @(-100);
bounce.toValue = @(100);
bounce.easing = RBBEasingFunctionEaseOutBounce;

bounce.additive = YES;
bounce.duration = 0.8;
```

You can also specify your own easing functions, from scratch:

```objc
RBBTweenAnimation *sinus = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
sinus.fromValue = @(0);
sinus.toValue = @(100);

sinus.easing = ^CGFloat (CGFloat fraction) {
    return sin((fraction) * 2 * M_PI);
};

sinus.additive = YES;
sinus.duration = 2;
```

<p align="center">
    <img src="http://robb.is/img/rbbanimation/sine-wave.gif" alt="Sine Wave" title="Custom Easing Function">
</p>

## License

RBBAnimation was built by [Robert Böhnke][robb]. It is licensed under the MIT
License.

If you use RBBAnimation in one of your apps, I'd love to hear about it. Feel
free to follow me on Twitter where I'm [@ceterum_censeo][twitter].

[caspringanimation]: https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/QuartzCore.framework/CASpringAnimation.h
[robb]: http://robb.is
[twitter]: https://twitter.com/ceterum_censeo
[cocoapods]: http://cocoapods.org/
