//
//  Player.cpp
//  CocosTest
//
//  Created by Evan Moore on 4/2/13.
//
//

#import "cocos2d.h"
using namespace cocos2d;

#import "SquareTarget.h"
#include "Player.h"

Player::Player() {
    this->currentTarget = NULL;
}

void Player::initWithColor(ccColor3B col) {
    this->color = col;
    this->touchLock = false;
    this->checkpointCount = 0;
    this->_identifier = 11011;
}

void Player::spawnNewTargetWithLayer(CCLayer * layer) {
    if(this->touchLock) return;
    
    CCPoint randPos = *new CCPoint(arc4random() % (int)layer->boundingBox().size.width, arc4random() % (int)layer->boundingBox().size.height);
    
    if(this->currentTarget == NULL){
        this->currentTarget = new SquareTarget();
        this->currentTarget->initWithPlayer(this);
        this->currentTarget->setPosition(randPos);
        layer->addChild(this->currentTarget);
    }
    
    this->currentTarget->runAction(
        CCSequence::actions(
            CCMoveTo::actionWithDuration(.05, randPos),
            //CCCallFunc::actionWithTarget((CCObject *)this, callfunc_selector(Player::unlockTouch)),
            NULL
        )
    );
}

void Player::unlockTouch(){
    this->touchLock = false;
}

int Player::getID(){
    return this->_identifier;
}
