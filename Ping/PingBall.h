//
//  PingBall.h
//  Ping
//
//  Created by Chase Marangu on 5/5/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AudioToolbox/AudioToolbox.h>

#define PING_PI (3.1415926535897932384626433832795028841971693993751058209749)
#define PING_DEG_TO_RAD(PING_DEG)(PING_PI * PING_DEG / 180.0)


@interface PingBall : NSObject

struct PingServe {
    float angle;
    float speed;
};

typedef struct PingServe PingServe;

@property CGRect rect;
@property PingServe velocity;

+ (instancetype)allocNewBallOnTable:(NSRect)pingTable;

+ (PingServe)makePingServeWithDirection:(float)direction magnitude:(float)magnitude;

- (void)draw;

- (void)move;

- (void)resetOnTable:(NSRect)pingTable withVelocity:(PingServe)velocity;

- (BOOL)didCollideWithBlock:(NSRect)pingBlock;

@end