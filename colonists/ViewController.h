//
//  ViewController.h
//  colonists
//
//  Created by Nader Hendawi on 2/2/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTurnBasedMatchHelper.h"

@interface ViewController : UIViewController <UITextFieldDelegate, GKTurnBasedEventHandlerDelegate> {
    IBOutlet UITextView *mainTextController;
    IBOutlet UITextField *textInputField;
    
}

- (IBAction)presentGCTurnViewController:(id)sender;
- (IBAction)sendTurn:(id)sender;
@end
