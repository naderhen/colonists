//
//  GCTurnBasedMatchHelper.h
//  colonists
//
//  Created by Nader Hendawi on 2/2/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate>{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch *currentMatch;

+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController;

@end
