//
//  RBBDampedHarmonicOscillatonSpec.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import "RBBDampedHarmonicOscillaton.h"

SpecBegin(RBBDampedHarmonicOscillaton)

it(@"should return correct values for fix points", ^{
    RBBOsciallation oscillation = RBBDampedHarmonicOscillation(1, 10, 1, 100, 0, YES);

    expect(oscillation(0.0)).to.beCloseToWithin( 1.00, 0.01);
    expect(oscillation(0.1)).to.beCloseToWithin( 0.65, 0.01);
    expect(oscillation(0.2)).to.beCloseToWithin( 0.15, 0.01);
    expect(oscillation(0.3)).to.beCloseToWithin(-0.12, 0.01);
    expect(oscillation(0.4)).to.beCloseToWithin(-0.15, 0.01);
    expect(oscillation(0.5)).to.beCloseToWithin(-0.07, 0.01);
    expect(oscillation(0.6)).to.beCloseToWithin( 0.00, 0.01);
    expect(oscillation(0.7)).to.beCloseToWithin( 0.02, 0.01);
    expect(oscillation(0.8)).to.beCloseToWithin( 0.02, 0.01);
    expect(oscillation(0.9)).to.beCloseToWithin( 0.00, 0.01);
    expect(oscillation(1.0)).to.beCloseToWithin( 0.00, 0.01);

    expect(oscillation(100)).to.beCloseToWithin(0, 0.01);
});

SpecEnd
