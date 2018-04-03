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
        NSLog(@"cmarangu is %s", cmarangu);
        [self setAnimationTimeInterval:1/30.0];
    }
    Ukey = Dkey = Wkey = Skey = false;
    score[0] = isPreview ? -1 : 0;
    score[1] = 0;
    self.ball = [PingBall allocNewBallOnTable:frame];
    NSRect frame2 = NSMakeRect(0, 0, frame.size.width, frame.size.height);
    self.paddle1 = [PingPaddle allocNewPaddleInTable:isPreview ? frame2 : frame onSide:LEFT];
    self.paddle1.autopiolot = false;
    self.paddle2 = [PingPaddle allocNewPaddleInTable:isPreview ? frame2 : frame onSide:RIGHT];
    self.paddle2.autopiolot = false;
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
    if (self.ball.rect.origin.x < -self.ball.rect.size.width || self.ball.rect.origin.x > self.frame.size.width) {
//        AudioServicesPlaySystemSound(kSystemSoundID_FlashScreen);
        score[self.ball.rect.origin.x < -self.ball.rect.size.width ? 1 : 0]++;
        [self.ball resetOnTable:self.frame withVelocity:[PingBall makePingServeWithDirection:arc4random() * 2 * PING_PI magnitude:5]];
    }
    if (self.ball.rect.origin.y < self.frame.origin.y ||
        self.ball.rect.origin.y + self.ball.rect.size.height > self.frame.size.height) {
        self.ball.velocity = [PingBall makePingServeWithDirection:self.ball.velocity.angle * -1.0
                                                        magnitude:self.ball.velocity.speed];
    }
    if ([self.ball didCollideWithBlock:self.paddle1.rect] || [self.ball didCollideWithBlock:self.paddle2.rect]) {
        AudioServicesPlaySystemSound(kSystemSoundID_UserPreferredAlert);
        self.ball.velocity = [PingBall makePingServeWithDirection:self.ball.velocity.angle * -1.0
                                                        magnitude:self.ball.velocity.speed * -1.5];
    }
    if (!self.paddle1.autopiolot)
    {
        if (Wkey) {
            [self.paddle1 moveUpOrDown:UP];
        }
        if (Skey) {
            [self.paddle1 moveUpOrDown:DOWN];
        }
    }
    else if ((self.ball.rect.origin.x + self.ball.rect.size.width / 2 < self.frame.origin.x + self.frame.size.width / 2) || cos(PING_DEG_TO_RAD(self.ball.velocity.angle)) * self.ball.velocity.speed < 0)
    {
        [self.paddle1 moveToBall:self.ball.rect];
    }
    if (!self.paddle2.autopiolot)
    {
        if (Ukey) {
            [self.paddle2 moveUpOrDown:UP];
        }
        if (Dkey) {
            [self.paddle2 moveUpOrDown:DOWN];
        }
    }
    else if ((self.ball.rect.origin.x + self.ball.rect.size.width / 2 > self.frame.origin.x + self.frame.size.width / 2) || cos(PING_DEG_TO_RAD(self.ball.velocity.angle)) * self.ball.velocity.speed > 0)
    {
        [self.paddle2 moveToBall:self.ball.rect];
    }
    [self.ball move];
    [self.ball draw];
    [self.paddle1 draw];
    [self.paddle2 draw];
//    scoreTextStorage = [[NSTextStorage alloc] initWithString:[NSString stringWithFormat:@"%i%i", score[0], score[1]]];
//  Credit to Apple's demo code for text drawing
    scoreTextStorage = [[NSTextStorage alloc] initWithString:[NSString stringWithFormat:@"%i:%i", score[0], score[1]]];
    scoreLayoutManager = [[NSLayoutManager alloc] init];
    scoreTextContainer = [[NSTextContainer alloc] init];
    [scoreLayoutManager addTextContainer:scoreTextContainer];
    [scoreTextStorage addLayoutManager:scoreLayoutManager];
    NSRange glyphRange = [scoreLayoutManager glyphRangeForTextContainer:scoreTextContainer];
    [self lockFocus];
    [scoreLayoutManager drawGlyphsForGlyphRange: glyphRange atPoint: NSMakePoint(self.frame.size.width / 2, self.frame.size.height - 50)];
    [self unlockFocus];
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
    return NO;
}

-(NSWindow *)configureSheet
{
    NSWindow* configSheet = [[[NSWindowController alloc] initWithWindowNibName:@"PingSettingsWindow"] window];
    return configSheet;
}

@end
