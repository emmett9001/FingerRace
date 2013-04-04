//
//  Player.cpp
//  CocosTest
//
//  Created by Evan Moore on 4/2/13.
//
//

#include "Player.h"

#import "cocos2d.h"
#import "SquareTarget.h"

Player::Player() {
    this->currentTarget = new SquareTarget();
}

void Player::initWithColor(cocos2d::ccColor3B col) {
    this->color = col;
}

void Player::spawnNewTargetWithLayer(cocos2d::CCLayer * layer) {
    this->killOldTarget();
    this->currentTarget = new SquareTarget();
    this->currentTarget->initWithColor(this->color);
    this->currentTarget->setPosition(*new cocos2d::CCPoint(arc4random() % (int)layer->boundingBox().size.width, arc4random() % (int)layer->boundingBox().size.height));
    layer->addChild(this->currentTarget);
}

void Player::killOldTarget() {
    this->currentTarget->removeFromParentAndCleanup(true);
}
