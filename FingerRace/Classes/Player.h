//
//  Player.h
//  CocosTest
//
//  Created by Evan Moore on 4/2/13.
//
//

#ifndef __CocosTest__Player__
#define __CocosTest__Player__

#include <iostream>

#import "cocos2d.h"

class SquareTarget;

class Player {
    
public:
    cocos2d::ccColor3B color;
    SquareTarget *currentTarget;
    
    Player();
    void initWithColor(cocos2d::ccColor3B col);
    void spawnNewTargetWithLayer(cocos2d::CCLayer * layer);
    void killOldTarget();
};

#endif /* defined(__CocosTest__Player__) */
