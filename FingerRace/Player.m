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

@synthesize color, currentTarget;

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
    [self killOldTarget];
    self.currentTarget = [SquareTarget spriteWithPlayer:self];
    self.currentTarget.position = CGPointMake(arc4random() % (int)[layer boundingBox].size.width, arc4random() % (int)[layer boundingBox].size.height);
    [layer addChild:self.currentTarget];
}

-(void)killOldTarget{
    [self.currentTarget removeFromParentAndCleanup:YES];
}

@end
