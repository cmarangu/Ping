//
//  PingView.m
//  Ping
//
//  Created by Chase Marangu on 4/24/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import "PingView.h"

@implementation PingView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    self.ball = [PingBall allocNewBallOnTable:frame];
    self.paddle1 = [PingPaddle allocNewPaddleInTable:frame onSide:LEFT];
    self.paddle2 = [PingPaddle allocNewPaddleInTable:frame onSide:RIGHT];
    
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    if (self.ball.rect.origin.x < -self.ball.rect.size.width | self.ball.rect.origin.x > self.frame.size.width) {
        [self.ball resetOnTable:self.frame withVelocity:[PingBall makePingServeWithDirection:135 magnitude:5]];
    }
    if (self.ball.rect.origin.y < self.frame.origin.x |
        self.ball.rect.origin.y + self.ball.rect.size.height > self.frame.size.height) {
        self.ball.velocity = [PingBall makePingServeWithDirection:self.ball.velocity.angle * -1
                                                        magnitude:self.ball.velocity.speed];
    }
    if (self.ball.rect.origin.x + self.ball.rect.size.width / 2 > self.frame.origin.x + self.frame.size.width / 2) {
        //[self.paddle2 moveToBall:self.ball.rect];
    }
    if ([self.ball didCollideWithBlock:self.paddle1.rect] | [self.ball didCollideWithBlock:self.paddle2.rect]) {
        self.ball.velocity = [PingBall makePingServeWithDirection:(self.ball.velocity.angle + 180) * -1
                                                        magnitude:self.ball.velocity.speed * 1.5];
    }
    [self.ball move];
    [self.ball draw];
    [self.paddle1 draw];
    [self.paddle2 draw];
}

- (void)keyDown:(NSEvent *)theEvent
{
    if ([[theEvent characters] isEqualToString:@"w"]) {
        [self.paddle1 moveUpOrDown:UP];
        [self.paddle1 moveUpOrDown:UP];
        [self.paddle1 moveUpOrDown:UP];
    } else if ([[theEvent characters] isEqualToString:@"s"]) {
        [self.paddle1 moveUpOrDown:DOWN];
        [self.paddle1 moveUpOrDown:DOWN];
        [self.paddle1 moveUpOrDown:DOWN];
    }
    if (theEvent.keyCode == 126) {
        [self.paddle2 moveUpOrDown:UP];
        [self.paddle2 moveUpOrDown:UP];
        [self.paddle2 moveUpOrDown:UP];
    } else if (theEvent.keyCode == 125) {
        [self.paddle2 moveUpOrDown:DOWN];
        [self.paddle2 moveUpOrDown:DOWN];
        [self.paddle2 moveUpOrDown:DOWN];
    }
}

- (void)keyUp:(NSEvent *)theEvent
{
    
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
//    NSWindow* pingConfigureSheet = [NSWindow windowNumbersWithOptions:NSWindowNumberListAllSpaces];
    return nil;
}

@end
