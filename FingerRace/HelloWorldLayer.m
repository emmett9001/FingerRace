//
//  HelloWorldLayer.m
//  FingerRace
//
//  Created by Emmett Butler on 3/31/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
        player1 = [Player player];
        [player1 spawnNewTargetWithLayer:self];
        
        player2 = [Player player];
        [player2 spawnNewTargetWithLayer:self];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView:[touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        NSLog(@"Registered a touch");
        //NSLog(@"player 1 touch nil: %d", player1.touch == nil);
        //NSLog(@"player 2 touch nil: %d", player2.touch == nil);
        
        if(player1.touch == nil && CGRectContainsPoint([player1.currentTarget boundingBox], touchLocation1)){
            player1.touch = touch;
        }
        if(player2.touch == nil && CGRectContainsPoint([player2.currentTarget boundingBox], touchLocation1)){
            player2.touch = touch;
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in [[event allTouches] allObjects]){
        CGPoint touchLocation1 = [touch locationInView: [touch view]];
        touchLocation1 = [[CCDirector sharedDirector] convertToGL:touchLocation1];
        
        //NSLog(@"player 1 touch id: %d", [player1.touch hash]);
        //NSLog(@"player 2 touch id: %d", [player2.touch hash]);
    
        if(touch == player1.touch && CGRectContainsPoint([player1.currentTarget boundingBox], touchLocation1)){
            [player1 spawnNewTargetWithLayer:self];
        }
        if(touch == player2.touch && CGRectContainsPoint([player2.currentTarget boundingBox], touchLocation1)){
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
