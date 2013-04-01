//
//  Player.m
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//
//

#import "Player.h"
#import "SquareTarget.h"

@implementation Player

@synthesize color, currentTarget, touch;

+(Player *)player{
    return [[Player alloc] initWithColor:ccc3(arc4random() % 255, arc4random() % 255, arc4random() % 255)];
}

-(Player *)initWithColor:(ccColor3B)col{
    if(self=[super init]){
        self.color = col;
    }
    return self;
}

-(void)spawnNewTargetWithLayer:(CCLayer *)layer{
    CGPoint randPos = CGPointMake(arc4random() % (int)[layer boundingBox].size.width, arc4random() % (int)[layer boundingBox].size.height);
    if(self.currentTarget == nil){
        self.currentTarget = [SquareTarget spriteWithPlayer:self];
        self.currentTarget.position = randPos;
        [layer addChild:self.currentTarget];
    }
    [self.currentTarget runAction:[CCMoveTo actionWithDuration:.1 position:randPos]];
}

@end
