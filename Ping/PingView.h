//
//  PingView.h
//  Ping
//
//  Created by Chase Marangu on 5/5/16.
//  Copyright (c) 2016 cmarangu. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <QuartzCore/QuartzCore.h>
#import "PingBall.h"
#import "PingPaddle.h"
#define cmarangu "the awesome author"

@interface PingView : ScreenSaverView {
    int score[2];
    NSTextStorage* scoreTextStorage;
    NSLayoutManager* scoreLayoutManager;
    NSTextContainer* scoreTextContainer;
    bool
        Ukey,
        Dkey,
        Wkey,
        Skey,
        ParticlesWitch
    ;
}

@property PingBall* ball;
@property PingPaddle* paddle1;
@property PingPaddle* paddle2;

@end
