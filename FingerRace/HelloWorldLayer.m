//
//  HelloWorldLayer.m
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "GameManager.h"

#pragma mark - HelloWorldLayer

#define NUM_PLAYERS 2
#define GOAL_CHECKPOINTS 10

@implementation HelloWorldLayer

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
        gameIsActive = YES;
        
        for(int i = 0; i < NUM_PLAYERS; i++){
            [[GameManager sharedManager].players addObject:[Player player]];
            [[[GameManager sharedManager].players objectAtIndex:i] spawnNewTargetWithLayer:self];
        }
        
        [self schedule:@selector(tick:)];
	}
	return self;
}

- (void) dealloc{
	[super dealloc];
}

-(void)tick:(ccTime)dt{
    for(int i = 0; i < NUM_PLAYERS; i++){
        Player *p1 = [[GameManager sharedManager].players objectAtIndex:i];
        
        if(gameIsActive && p1.checkpointCount >= GOAL_CHECKPOINTS){
            NSLog(@"Winner!");
            gameIsActive = NO;
        }
        
        for(int j = 0; j < NUM_PLAYERS; j++){
            Player *p2 = [[GameManager sharedManager].players objectAtIndex:j];
            if(p1 == p2) continue;
            
            if(CGRectIntersectsRect(p1.currentTarget.boundingBox, p2.currentTarget.boundingBox)){
                [self resolveTargetCollision];
            }
        }
    }
}

-(void)resolveTargetCollision{
    for(int i = 0; i < NUM_PLAYERS; i++){
        [[[GameManager sharedManager].players objectAtIndex:i] spawnNewTargetWithLayer:self];
    }
    
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView:[touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        for(int i = 0; i < NUM_PLAYERS; i++){
            Player *p1 = [[GameManager sharedManager].players objectAtIndex:i];
            if(p1.touch == nil && CGRectContainsPoint([p1.currentTarget boundingBox], touchLocation1)){
                p1.touch = touch;
            }
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView: [touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        for(int i = 0; i < NUM_PLAYERS; i++){
            Player *p1 = [[GameManager sharedManager].players objectAtIndex:i];
            if(touch == p1.touch && CGRectContainsPoint([p1.currentTarget boundingBox], touchLocation1)){
                if(!p1.touchLock){
                    [p1 spawnNewTargetWithLayer:self];
                    p1.checkpointCount += 1;
                    p1.touchLock = YES;
                }
            }
        }
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView:[touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        for(int i = 0; i < NUM_PLAYERS; i++){
            Player *p1 = [[GameManager sharedManager].players objectAtIndex:i];
            if(touch == p1.touch){
                p1.touch = nil;
            }
        }
    }
}

@end
