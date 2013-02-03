//
//  ViewController.h
//  colonists
//
//  Created by Nader Hendawi on 2/2/13.
//  Copyright (c) 2013 Nader Hendawi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTurnBasedMatchHelper.h"

@interface ViewController : UIViewController <UITextFieldDelegate, GCTurnBasedMatchHelperDelegate> {
    IBOutlet UITextView *mainTextController;
    IBOutlet UITextField *textInputField;
    IBOutlet UIView *inputView;
    IBOutlet UILabel *statusLabel;
}

- (IBAction)presentGCTurnViewController:(id)sender;
- (IBAction)sendTurn:(id)sender;
@end
