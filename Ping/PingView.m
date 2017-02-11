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
    Ukey = Dkey = Wkey = Skey = false;
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
    if (Wkey) {
        [self.paddle1 moveUpOrDown:UP];
        [self.paddle1 moveUpOrDown:UP];
        [self.paddle1 moveUpOrDown:UP];
    }
    if (Skey) {
        [self.paddle1 moveUpOrDown:DOWN];
        [self.paddle1 moveUpOrDown:DOWN];
        [self.paddle1 moveUpOrDown:DOWN];
    }
    if (Ukey) {
        [self.paddle2 moveUpOrDown:UP];
        [self.paddle2 moveUpOrDown:UP];
        [self.paddle2 moveUpOrDown:UP];
    }
    if (Dkey) {
        [self.paddle2 moveUpOrDown:DOWN];
        [self.paddle2 moveUpOrDown:DOWN];
        [self.paddle2 moveUpOrDown:DOWN];
    }
    [self.ball move];
    [self.ball draw];
    [self.paddle1 draw];
    [self.paddle2 draw];
}

- (void)keyDown:(NSEvent *)theEvent
{
    if ([[theEvent characters] isEqualToString:@"w"]) {
        Wkey = true;
    } else if ([[theEvent characters] isEqualToString:@"s"]) {
        Skey = true;
    }
    if (theEvent.keyCode == 126) {
        Ukey = true;
    } else if (theEvent.keyCode == 125) {
        Dkey = true;
    }
}

- (void)keyUp:(NSEvent *)theEvent
{
    if ([[theEvent characters] isEqualToString:@"w"]) {
        Wkey = false;
    }
    if ([[theEvent characters] isEqualToString:@"s"]) {
        Skey = false;
    }
    if (theEvent.keyCode == 126) {
        Ukey = false;
    }
    if (theEvent.keyCode == 125) {
        Dkey = false;
    }
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
