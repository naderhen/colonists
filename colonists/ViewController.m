//
//  ViewController.m
//  colonists
//
//  Created by Nader Hendawi on 2/2/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    textInputField.delegate = self;
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    textInputField.enabled= NO;
    statusLabel.text = @"Welcome. Press Game Center to get started";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (IBAction)presentGCTurnViewController:(id)sender {
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

- (IBAction)sendTurn:(id)sender {
    GKTurnBasedMatch *currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];

    NSString *newStoryString;
    if ([textInputField.text length] > 250) {
        newStoryString = [textInputField.text substringToIndex:249];
    } else {
        newStoryString = textInputField.text;
    }
    
    NSString *sendString = [NSString stringWithFormat:@"%@ %@", mainTextController.text, newStoryString];
    NSData *data = [sendString dataUsingEncoding:NSUTF8StringEncoding];
    mainTextController.text = sendString;
    
    NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
    GKTurnBasedParticipant *nextParticipant;
    
    NSUInteger nextIndex = (currentIndex + 1) % [currentMatch.participants count];
    nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
    
    for (int i = 0; i < [currentMatch.participants count]; i++) {
        nextParticipant = [currentMatch.participants objectAtIndex:((currentIndex + 1 + i) % [currentMatch.participants count])];
        if (nextParticipant.matchOutcome != GKTurnBasedMatchOutcomeQuit) {
            break;
        }
    }
    
    [currentMatch endTurnWithNextParticipants:[[NSArray alloc] initWithObjects:nextParticipant, nil] turnTimeout:GKTurnTimeoutDefault matchData:data completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            statusLabel.text = @"Oops, there was a problem. Try that again.";
        } else {
            statusLabel.text = @"Your turn is over.";
            textInputField.enabled = NO;
        }
    }];
    

    NSLog(@"Send Turn, %@, %@", data, nextParticipant);
    textInputField.text = @"";
    
}

#pragma mark - GCTurnBasedMatchHelperDelegate

-(void)enterNewGame:(GKTurnBasedMatch *)match {
    NSLog(@"Entering New Game...");
    statusLabel.text = @"Player 1's Turn (That's You!)";
    textInputField.enabled = YES;
    Deck *deck = [[Deck alloc] init];
    [deck shuffle];
    [GCTurnBasedMatchHelper sharedInstance].deck = deck;
    
    NSString *tileString = [NSString stringWithFormat:@"%@", deck.tiles];
    
    mainTextController.text = tileString;
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
    NSLog(@"Taking turn for existing game...");
    int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
    NSString *statusString = [NSString stringWithFormat:@"Player %d's Turn (That's You)", playerNum];
    statusLabel.text = statusString;
    textInputField.enabled = YES;
    if ([match.matchData bytes]) {
        NSString *storySoFar = [NSString stringWithUTF8String:[match.matchData bytes]];
        mainTextController.text = storySoFar;
    }
}

-(void)layoutMatch:(GKTurnBasedMatch *)match {
    NSLog(@"Viewing match where it's not our turn");
    NSString *statusString;
    
    if (match.status == GKTurnBasedMatchStatusEnded) {
        statusString = @"Match Ended";
    } else {
        int playerNum = [match.participants indexOfObject:match.currentParticipant] + 1;
        statusString = [NSString stringWithFormat:@"Player %d's Turn", playerNum];
    }
    statusLabel.text = statusString;
    textInputField.enabled = NO;
    NSString *storySoFar = [NSString stringWithUTF8String:[match.matchData bytes]];
    mainTextController.text = storySoFar;
}

-(void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Another game needs your attention!" message:notice delegate:self cancelButtonTitle:@"Sweet!" otherButtonTitles:nil, nil];
    [av show];
}

@end
