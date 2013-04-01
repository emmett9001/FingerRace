//
//  SquareTarget.h
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//
//

#import "cocos2d.h"

@class Player;

@interface SquareTarget : CCSprite
{
    ccColor3B color;
}

@property (nonatomic, retain) Player *player;

+(SquareTarget *)spriteWithPlayer:(Player *)player;
-(void)wasTouched;

@end
