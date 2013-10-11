//
//  RBBBlockBasedArray.h
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBBBlockBasedArray : NSArray

+ (instancetype)arrayWithCount:(NSUInteger)count block:(id (^)(NSUInteger))block;

- (instancetype)initWithCount:(NSUInteger)count block:(id (^)(NSUInteger))block;

@end
