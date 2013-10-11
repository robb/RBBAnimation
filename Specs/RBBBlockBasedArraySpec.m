//
//  RBBBlockBasedArraySpec.m
//  RBBAnimation
//
//  Created by Robert Böhnke on 10/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import "RBBBlockBasedArray.h"

SpecBegin(RBBBlockBasedArray)

describe(@"A block-based array", ^{
    __block NSArray *array;

    beforeEach(^{
        array = [RBBBlockBasedArray arrayWithCount:5 block:^(NSUInteger idx) {
            return @(idx);
        }];
    });

    it(@"should have a count", ^{
        expect(array).to.haveCountOf(5);
    });

    it(@"should allow access to elements", ^{
        expect(array[0]).to.equal(@0);
        expect(array[2]).to.equal(@2);
    });

    it(@"should equal existing 'normal' arrays", ^{
        expect(array).to.equal((@[ @0, @1, @2, @3, @4 ]));

        expect((@[ @0, @1, @2, @3, @4 ])).to.equal(array);
    });

    it(@"should support -firstObject", ^{
        expect(array.firstObject).to.equal(@0);
    });

    it(@"should support -lastObject", ^{
        expect(array.lastObject).to.equal(@4);
    });
});

it(@"should initialize with a count and a block", ^{
    NSArray *array = [RBBBlockBasedArray arrayWithCount:2 block:^(NSUInteger idx) {
        return @(idx);
    }];

    expect(array).notTo.beNil();
});

it(@"should initialize", ^{
    NSArray *array = [[RBBBlockBasedArray alloc] init];

    expect(array).notTo.beNil();
    expect(array).to.equal(@[]);
});

it(@"should intialize with objects and a count", ^{
    id objects[3] = { @1, @2, @3 };

    NSArray *array = [[RBBBlockBasedArray alloc] initWithObjects:objects count:3];

    expect(array).notTo.beNil();
    expect(array).to.equal((@[ @1, @2, @3 ]));
});

SpecEnd
