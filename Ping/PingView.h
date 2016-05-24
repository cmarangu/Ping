//
//  PingView.h
//  Ping
//
//  Created by Chase Marangu on 5/5/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "PingBall.h"
#import "PingPaddle.h"

@interface PingView : ScreenSaverView

@property PingBall* ball;
@property PingPaddle* paddle1;
@property PingPaddle* paddle2;

@end
