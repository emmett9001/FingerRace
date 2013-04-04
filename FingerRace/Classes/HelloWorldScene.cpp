#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"

#import "Player.h"
#import "SquareTarget.h"

using namespace cocos2d;

Player *player1, *player2;

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();
    
    // add layer as a child to scene
    scene->addChild(layer);
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    this->setTouchEnabled(true);
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);
    
    player1 = new Player::Player();
    player1->initWithColor(cocos2d::ccc3(arc4random() % 255, arc4random() % 255, arc4random() % 255));
    player1->spawnNewTargetWithLayer(this);
    
    player2 = new Player::Player();
    player2->initWithColor(cocos2d::ccc3(arc4random() % 255, arc4random() % 255, arc4random() % 255));
    player2->spawnNewTargetWithLayer(this);
    
    return true;
}

bool HelloWorld::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent) {
    CCPoint touchLocation = pTouch->getLocationInView();
    touchLocation = CCDirector::sharedDirector()->convertToGL(touchLocation);
    
    if (player1->currentTarget->boundingBox().containsPoint(touchLocation)) {
        player1->spawnNewTargetWithLayer(this);
    }
    
    return true;
}

void HelloWorld::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent) {
    CCPoint touchLocation = pTouch->getLocationInView();
    touchLocation = CCDirector::sharedDirector()->convertToGL(touchLocation);
    
    if (player1->currentTarget->boundingBox().containsPoint(touchLocation)) {
        player1->spawnNewTargetWithLayer(this);
    } else if (player2->currentTarget->boundingBox().containsPoint(touchLocation)) {
        player2->spawnNewTargetWithLayer(this);
    }
}
