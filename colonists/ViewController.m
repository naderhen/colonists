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
    nextParticipant = [currentMatch.participants objectAtIndex:((currentIndex + 1) % [currentMatch.participants count])];
    [currentMatch endTurnWithNextParticipant:nextParticipant matchData:data completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    NSLog(@"Send Turn, %@, %@", data, nextParticipant);
    textInputField.text = @"";
}

#pragma mark - GCTurnBasedMatchHelperDelegate

-(void)enterNewGame:(GKTurnBasedMatch *)match {
    NSLog(@"Entering New Game...");
    Deck *deck = [[Deck alloc] init];
    [deck shuffle];
    [GCTurnBasedMatchHelper sharedInstance].deck = deck;
    
    NSString *tileString = [NSString stringWithFormat:@"%@", deck.tiles];
    
    mainTextController.text = tileString;
}

-(void)takeTurn:(GKTurnBasedMatch *)match {
    NSLog(@"Taking turn for existing game...");
    if ([match.matchData bytes]) {
        NSString *storySoFar = [NSString stringWithUTF8String:[match.matchData bytes]];
        mainTextController.text = storySoFar;
    }
}

@end
