//
//  PingBall.m
//  Ping
//
//  Created by Chase Marangu on 5/5/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import "PingBall.h"

@implementation PingBall : NSObject

+ (instancetype)allocNewBallOnTable:(NSRect)pingTable
{
    CGFloat tx, ty, tw, th, bd;
    tx = pingTable.origin.x;
    ty = pingTable.origin.y;
    tw = pingTable.size.width;
    th = pingTable.size.height;
    bd = th <= tw ? th / 10 : tw / 10;
    PingBall *pingBall = [PingBall alloc];
    pingBall.rect = CGRectMake(tx + tw / 2 - bd / 2, ty + th / 2 - bd / 2, bd, bd);
    pingBall.velocity = [PingBall makePingServeWithDirection:arc4random() * 2 * PING_PI magnitude:5];
    return pingBall;
}

+ (PingServe)makePingServeWithDirection:(float)direction magnitude:(float)magnitude
{
    PingServe vector;
    vector.angle = direction;
    vector.speed = magnitude;
    return vector;
}

- (void)draw
{
    [[NSColor cyanColor] set];
    [[NSBezierPath bezierPathWithOvalInRect:self.rect] fill];
}

- (void)move
{
    CGFloat x, y, dx, dy, w, h;
    x = self.rect.origin.x;
    y = self.rect.origin.y;
    dx = cos(PING_DEG_TO_RAD(self.velocity.angle)) * self.velocity.speed;
    dy = sin(PING_DEG_TO_RAD(self.velocity.angle)) * self.velocity.speed;
    w = self.rect.size.width;
    h = self.rect.size.height;
    self.rect = CGRectMake(x + dx, y + dy, w, h);
}

- (void)resetOnTable:(NSRect)pingTable withVelocity:(PingServe)velocity
{
    CGFloat tx, ty, tw, th, bd;
    tx = pingTable.origin.x;
    ty = pingTable.origin.y;
    tw = pingTable.size.width;
    th = pingTable.size.height;
    bd = th <= tw ? th / 10 : tw / 10;
    self.rect = CGRectMake(tx + tw / 2 - bd / 2, ty + th / 2 - bd / 2, bd, bd);
    self.velocity = velocity;
}

- (BOOL)didCollideWithBlock:(NSRect)pingBlock
{
    CGFloat bx, by, bw, bh;
    CGFloat px, py, pw, ph;
    bx = self.rect.origin.x;
    by = self.rect.origin.y;
    bw = self.rect.size.width;
    bh = self.rect.size.height;
    px = pingBlock.origin.x;
    py = pingBlock.origin.y;
    pw = pingBlock.size.width;
    ph = pingBlock.size.height;
    if (by + bh / 2 > py & by + bh / 2 < py + ph) {
        if (bx < px + pw & bx > px) {
            return YES;
        }
        if (bx + bw > px & bx + bw < px + pw) {
            return YES;
        }
    }
    return NO;
}

@end