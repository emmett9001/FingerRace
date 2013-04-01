//
//  Player.h
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@class SquareTarget;

@interface Player : NSObject
{

}

@property (nonatomic) ccColor3B color;
@property (nonatomic) BOOL touchLock;
@property (nonatomic) NSInteger checkpointCount;
@property (nonatomic, retain) UITouch *touch;
@property (nonatomic, retain) SquareTarget *currentTarget;

+(Player *)player;
-(Player *)initWithColor:(ccColor3B)col;
-(void)spawnNewTargetWithLayer:(CCLayer *)layer;

@end
