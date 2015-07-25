//
//  LogInVC.h
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParsingLogInClasses.h"
#import "Request.h"
@interface LogInVC : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,RequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(strong, nonatomic) NSMutableData  *responseData;


//methode amd button actions
- (IBAction)logInButtonAction:(id)sender;



// Outlets
@property (weak, nonatomic) IBOutlet UITextField *userNameTextOutlet;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextOutlet;
//@property(strong,nonatomic) UINavigationController *navigationController;



- (IBAction)button_forgotPassword:(id)sender;


@end
