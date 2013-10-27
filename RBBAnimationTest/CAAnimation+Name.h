//
//  CAAnimation+Name.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/13/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Name)

@property (readwrite, nonatomic, copy) NSString *rbb_name;

@end
