//
//  GCTurnBasedMatchHelper.h
//  colonists
//
//  Created by Nader Hendawi on 2/2/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "Deck.h"

@protocol GCTurnBasedMatchHelperDelegate

- (void)enterNewGame:(GKTurnBasedMatch *)match;
- (void)layoutMatch:(GKTurnBasedMatch *)match;
- (void)takeTurn:(GKTurnBasedMatch *)match;
- (void)receiveEndGame:(GKTurnBasedMatch *)match;
- (void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match;

@end

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate>{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
    
    id <GCTurnBasedMatchHelperDelegate> delegate;
}


@property (nonatomic, retain) id <GCTurnBasedMatchHelperDelegate> delegate;
@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch *currentMatch;
@property (retain) Deck *deck;

+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController;

@end
