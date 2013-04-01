//
//  GameManager.h
//  FingerRace
//
//  Created by Emmett Butler on 4/1/13.
//
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject
{
}

@property (nonatomic, retain) NSMutableArray *players;

+(GameManager *)sharedManager;

@end
