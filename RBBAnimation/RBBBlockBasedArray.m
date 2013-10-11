//
//  RBBBlockBasedArray.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"

@implementation RBBBlockBasedArray {
    NSUInteger _count;
    id (^_block)(NSUInteger);
}

#pragma mark - Lifecycle

+ (instancetype)arrayWithCount:(NSUInteger)count block:(id (^)(NSUInteger))block {
    return [[self alloc] initWithCount:count block:block];
}

- (instancetype)initWithCount:(NSUInteger)count block:(id (^)(NSUInteger))block {
    self = [super init];
    if (self == nil) return nil;

    _count = count;
    _block = [block copy];

    return self;
}

- (instancetype)init {
    return [self initWithCount:0 block:nil];
}

- (instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt {
    NSArray *otherArray = [NSArray arrayWithObjects:objects count:cnt];

    return [self initWithCount:cnt block:^(NSUInteger idx) {
        return otherArray[idx];
    }];
}

#pragma mark - NSArray primitive methods

- (NSUInteger)count {
    return _count;
}

- (id)objectAtIndex:(NSUInteger)index {
    return _block(index);
}

@end
