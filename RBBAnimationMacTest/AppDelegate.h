//
//  AppDelegate.h
//  RBBAnimationMacTest
//
//  Created by Paulo Andrade on 13/11/13.
//  Copyright (c) 2013 Robert Böhnke. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *redView;

@property (nonatomic) NSArray *animations;
@property (weak) IBOutlet NSPopUpButton *animationsPopUp;

- (IBAction)popUpValueChanged:(id)sender;
@end
