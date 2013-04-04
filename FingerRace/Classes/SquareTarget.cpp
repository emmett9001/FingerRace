//
//  SquareTarget.cpp
//  CocosTest
//
//  Created by Evan Moore on 4/2/13.
//
//

#include "SquareTarget.h"
#include "Player.h"

#import "cocos2d.h"

SquareTarget::SquareTarget() {
    
}

void SquareTarget::initWithPlayer(Player *p) {
    this->initWithFile("square.png");
    this->setColor(p->color);
}

void SquareTarget::wasTouched() {
    cocos2d::CCScaleTo *scaleOne = new cocos2d::CCScaleTo();
    scaleOne->initWithDuration(0.13, 1.3);
    
    cocos2d::CCScaleTo *scaleTwo = new cocos2d::CCScaleTo();
    scaleTwo->initWithDuration(0.13, 1.0);
    
    cocos2d::CCSequence *sequence = new cocos2d::CCSequence();
    sequence->initWithTwoActions(scaleOne, scaleTwo);
}
