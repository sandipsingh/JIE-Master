//
//  SignUpVC.h
//  JiE
//
//  Created by neeraj on 24/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
@interface SignUpVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,RequestDelegate>
- (IBAction)imagePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *imagePickerOutLet;




//UI field outlets
@property (weak, nonatomic) IBOutlet UITextField *userName_OutLet;
@property (weak, nonatomic) IBOutlet UITextField *email_OutLet;
@property (weak, nonatomic) IBOutlet UITextField *passw0rd_OutLet;
@property (weak, nonatomic) IBOutlet UITextField *DOB_Outlet;
//UI BUttons

- (IBAction)button_SignUP:(id)sender;


@property (weak, nonatomic) IBOutlet UIDatePicker *smallPicker;




- (IBAction)btn:(id)sender;

- (IBAction)DOB_Action:(id)sender;


@property (strong,nonatomic) NSMutableData *responseData;
@end
