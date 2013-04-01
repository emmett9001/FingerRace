//
//  GameManager.m
//  FingerRace
//
//  Created by Emmett Butler on 4/1/13.
//
//

#import "GameManager.h"

static GameManager *sharedInstance = nil;

@implementation GameManager

+(GameManager *)sharedManager{
    @synchronized(self){
        if(sharedInstance == nil){
            [[self alloc] init];
        }
    }
    return sharedInstance;
}

-(id)init{
    @synchronized(self) {
        [super init];
        return self;
    }
}

// singleton boilerplate

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (sharedInstance == nil){
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)retain{
    return self;
}

-(void)release{/* do nothing */}

- (id)autorelease{
    return self;
}

- (NSUInteger)retainCount{
    return NSUIntegerMax; // This is sooo not zero
}

@end
