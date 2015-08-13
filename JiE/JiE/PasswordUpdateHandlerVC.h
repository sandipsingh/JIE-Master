//
//  PasswordUpdateHandlerVC.h
//  JiE
//
//  Created by vikas on 13/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordUpdateHandlerVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *userEmail;


@property (weak, nonatomic) IBOutlet UITextField *userOldPassword;


@property (weak, nonatomic) IBOutlet UITextField *userNewPassword;
@property (strong, nonatomic) NSMutableData *responseData;
- (IBAction)submitBotton:(id)sender;

@end
