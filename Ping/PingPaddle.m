//
//  PingPaddle.h
//  Ping
//
//  Created by Chase Marangu on 5/7/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import "PingPaddle.h"

@implementation PingPaddle : NSObject

+ (instancetype)allocNewPaddleInTable:(NSRect)pingTable onSide:(PingSide)pingSide
{
    CGFloat tx, ty, tw, th, px, py, pw, ph;
    tx = pingTable.origin.x;
    ty = pingTable.origin.y;
    tw = pingTable.size.width;
    th = pingTable.size.height;
    pw = th <= tw ? th / 20 : tw / 20;
    ph = pw * 6;
    px = pingSide == LEFT ? tx + tw / 6 - pw / 2 : pingSide == RIGHT ? (tx + tw) - tw / 6 - pw / 2 : 0;
    py = ty + th / 2 - ph / 2;
    PingPaddle *pingPaddle = [PingPaddle alloc];
    pingPaddle.side = pingSide;
    pingPaddle.speed = 3;
    pingPaddle.rect = CGRectMake(px, py, pw, ph);
    return pingPaddle;
}

- (void)draw
{
    [[NSColor blueColor] set];
    NSRectFill(self.rect);
}

- (void)moveUpOrDown:(PingSide)upOrDown
{
    if (upOrDown == UP) {
        self.rect = CGRectMake(self.rect.origin.x, self.rect.origin.y + self.speed, self.rect.size.width, self.rect.size.height);
    } else if (upOrDown == DOWN) {
        self.rect = CGRectMake(self.rect.origin.x, self.rect.origin.y - self.speed, self.rect.size.width, self.rect.size.height);
    }
}

- (void)moveToBall:(NSRect)pingBallRect
{
    CGFloat px, py, pw, ph, by;
    px = self.rect.origin.x;
    py = self.rect.origin.y;
    pw = self.rect.size.width;
    ph = self.rect.size.height;
    by = pingBallRect.origin.y + pingBallRect.size.height / 2;
    if (py + ph / 2 < by) {
        [self moveUpOrDown:UP];
    } else {
        [self moveUpOrDown:DOWN];
    }
}

@end