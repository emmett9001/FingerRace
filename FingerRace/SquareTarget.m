//
//  SquareTarget.m
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//
//

#import "SquareTarget.h"
#import "Player.h"

@implementation SquareTarget

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect{
    if( (self=[super initWithTexture:texture rect:rect])){
        
    }
    return self;
}

+ (id)spriteWithPlayer:(Player *)player{
    SquareTarget *sprite = [SquareTarget spriteWithFile:@"square.png"];
    [sprite setColor:player.color];
    [sprite setScale:4];
    return sprite;
}

-(void)wasTouched{
    [self runAction:
     [CCSequence actions:
      [CCScaleTo actionWithDuration:.13 scale:1.3],
      [CCScaleTo actionWithDuration:.13 scale:1],
      nil]
     ];
}

@end
