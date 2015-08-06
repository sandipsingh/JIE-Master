//
//  AccountsViewController.h
//  JiE
//
//  Created by vikas on 25/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogInVC.h"

@interface AccountsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtField;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property(strong, nonatomic) NSMutableData *responseData;

- (IBAction)buttonPress:(id)sender;

@end
