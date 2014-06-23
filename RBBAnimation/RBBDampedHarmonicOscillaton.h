//
//  RBBDampedHarmonicOscillaton.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/04/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef CGFloat (^RBBOsciallation)(CGFloat t);

RBBOsciallation RBBDampedHarmonicOscillation(CGFloat x0, CGFloat damping, CGFloat mass, CGFloat stiffness, CGFloat velocity, BOOL allowsOverdamping);
