//
//  RBBBlockBasedArray.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^RBBBlockBasedArrayBlock)(NSUInteger idx);

@interface RBBBlockBasedArray : NSArray

+ (instancetype)arrayWithCount:(NSUInteger)count block:(RBBBlockBasedArrayBlock)block;

- (instancetype)initWithCount:(NSUInteger)count block:(RBBBlockBasedArrayBlock)block;

@end
