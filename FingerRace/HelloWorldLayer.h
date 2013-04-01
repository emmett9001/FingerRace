//
//  HelloWorldLayer.h
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "SquareTarget.h"
#import "Player.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    BOOL gameIsActive;
}

+(CCScene *) scene;

@end
