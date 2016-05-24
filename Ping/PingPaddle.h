//
//  PingPaddle.h
//  Ping
//
//  Created by Chase Marangu on 5/7/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PingPaddle : NSObject

typedef enum : NSUInteger {
    LEFT,
    RIGHT,
    UP,
    DOWN,
} PingSide;

@property CGRect rect;
@property PingSide side;
@property CGFloat speed;

+ (instancetype)allocNewPaddleInTable:(NSRect)pingTable onSide:(PingSide)pingSide;

- (void)draw;

- (void)moveUpOrDown:(PingSide)upOrDown;

- (void)moveToBall:(NSRect)pingBallRect;

@end