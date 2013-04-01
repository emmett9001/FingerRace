//
//  HelloWorldLayer.m
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import "HelloWorldLayer.h"
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
        player1 = [Player player];
        [player1 spawnNewTargetWithLayer:self];
        
        player2 = [Player player];
        [player2 spawnNewTargetWithLayer:self];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView:[touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        if(player1.touch == nil && CGRectContainsPoint([player1.currentTarget boundingBox], touchLocation1)){
            player1.touch = touch;
        } else if(player2.touch == nil && CGRectContainsPoint([player2.currentTarget boundingBox], touchLocation1)){
            player2.touch = touch;
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView: [touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];

        if(touch == player1.touch && CGRectContainsPoint([player1.currentTarget boundingBox], touchLocation1)){
            [player1 spawnNewTargetWithLayer:self];
        } else if(touch == player2.touch && CGRectContainsPoint([player2.currentTarget boundingBox], touchLocation1)){
            [player2 spawnNewTargetWithLayer:self];
        }
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView:[touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        if(touch == player1.touch){
            player1.touch = nil;
        } else if(touch == player2.touch){
            player2.touch = nil;
        }
    }
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
