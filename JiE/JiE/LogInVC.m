//
//  LogInVC.m
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "LogInVC.h"
#import "ParsingLogInClasses.h"
#import "MBProgressHUD.h"
#import "LoggedInUserVC.h"
#import "ForgotPassword.h"
#import "MainVC.h"
#import "UserDetail.h"
#import "AppDelegate.h"
@interface LogInVC (){
    NSString *logInURLString;
    MBProgressHUD *HUD;
    BOOL loginResult ;
    UITextField *activeField;
}
@end

@implementation LogInVC  
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Making navigation bar transparent only back button is displayed
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0 green:255 blue:0 alpha:.4];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - text field
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameTextOutlet) {
        [_passwordTextField becomeFirstResponder];
    }
    else{
         [textField resignFirstResponder];
    }
    return YES;
}
//****************************** Web Service call *************************

//*******************************************WEB SERVICE CALLING SECTION***********************

- (void)logInWebService:(NSString*)userName andpassword:(NSString*)password
{
    _lReq = getLogin;
    Request * reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj loginWithUserName:userName withPassword:password];
}
-(void)updateDeviceTokenWithUser:(NSString *)userId
{
     _lReq = updateDeviceToken;
    Request * reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj updateDeviceToken:[[NSUserDefaults standardUserDefaults] objectForKey:pushtoken] WithUserId:userId];
}
-(void)getError{
    [HUD hide:YES];
}
-(void)getResult:(id)response{
    switch (_lReq) {
        case getLogin:
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)response;
                    loginResult = [[dict objectForKey:@"result"] boolValue];
                    id result = [dict objectForKey:@"result1"];
                    if ([result isKindOfClass:[NSArray class]])
                     
                    {
                        NSArray *array = (NSArray *)result;
                        for (NSDictionary *dic in array) {
                            
                            UserDetail *obj = [[UserDetail alloc] init];
                            
                            obj.dob = [dic objectForKey:@"dob"];
                            obj.email = [dic objectForKey:@"email"];
                            obj.userId = [dic objectForKey:@"id"];
                            obj.profilepic = [dic objectForKey:@"profilepic"];
                            obj.username = [dic objectForKey:@"username"];
                            saveUserData(obj);
                            [self.LoginDetails addObject : obj];
                            
                            [self updateDeviceTokenWithUser:obj.userId];
                            
                            
                           //////////////////////////////////////////
                            
                           
              
                            
                            
                            [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"email"] forKey:@"USER_EMAIL"];
                             [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"dob"] forKey:@"USER_DOB"];
                             [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"username"] forKey:@"USER_NAME"];
                           [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"profilepic"]forKey:@"USER_NAME_1"];
                            
                            ///////////////////////////////////////////////////////
                            
                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                
                             NSURL *profileURL = [NSURL URLWithString:[obj.profilepic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

                                
                        // NSURL *profileURL = [NSURL URLWithString:[@"http://static.dnaindia.com/sites/default/files/2015/08/05/362359-salman-khan.jpg" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                                
                                
                            NSData *profilePic = [NSData dataWithContentsOfURL:profileURL];
                            if (profilePic!=nil) {
                                UIImage *profileImage = [[UIImage alloc]initWithData:profilePic];
                                   if (profileImage!=nil) {
                                    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
                                    NSData *profileImageData = UIImagePNGRepresentation(profileImage);
                                [[NSFileManager defaultManager]createFileAtPath:[docDir stringByAppendingPathComponent:@"profile.png"] contents:profileImageData attributes:nil];
                                        
                                    }
                                }
                                
                                
                            });

                            
                            
                            ////////////////////////
                            
                            
                            
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                       
                            
             

                            
                            
                            //////////////////////////////////////
                            break;
                        }
                    }
                
                
                [HUD hide:YES];
                // redirection user to the app as per login status
                if(loginResult  == true){
                    UINavigationController *mainVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
                    [((AppDelegate *)[UIApplication sharedApplication].delegate).window setRootViewController:mainVCObj];
                    [((AppDelegate *)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Incorrect Username/Password" delegate:nil //or self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                    [alert show];
                }
            }
            else{
                NSLog(@"Web service returned null");
            }
        }
            break;
        case updateDeviceToken:
        {
            NSLog(@"Successfully Updated");
        }
        default:
            break;
    }
}
- (IBAction)logInButtonAction:(id)sender {
  //  MainVC *mainVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    //[self.navigationController pushViewController:mainVCObj animated:YES];
    [self validateLogIn];
}
-(void)validateLogIn
{
    if([self.userNameTextOutlet.text isEqualToString:@""]||[self.passwordTextOutlet.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Username/Password fields are mandatory" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
    
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString *errorMessage;
    errorMessage=nil;
    if (![emailPredicate evaluateWithObject:self.userNameTextOutlet.text]){
        [self.userNameTextOutlet becomeFirstResponder];
        errorMessage= @"Please enter a valid email address";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter valid Email" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
        //    else if (self.passwordTextField.text.length <= 4){
        //        [self.passwordTextField becomeFirstResponder];
        //        errorMessage = @"Password must be 4 chracter long";
        //    }
    }
    else{
        [self logInWebService : self.userNameTextOutlet.text andpassword : self.passwordTextOutlet.text];
        HUD= [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        [HUD show:YES];
    }
    
}

- (IBAction)button_forgotPassword:(id)sender {
    //    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Forgot Password" message:@"Please Enter your email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forgot Password" message:@"Please Enter Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setPlaceholder:@"Email"];
    // [alert addButtonWithTitle:@"Send"];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1)
    {
        UITextField *email_By_User = [alertView textFieldAtIndex:0];
        ForgotPassword *forgotClassObj=[[ForgotPassword alloc]init];
        [forgotClassObj forgotPasswordWebService:email_By_User.text];
        NSLog(@"username: %@", email_By_User.text);
    }
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if( ![inputText isEqualToString:@""] )
    {
        NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        NSString *errorMessage;
        errorMessage=nil;
        if (![emailPredicate evaluateWithObject:inputText]){
            return NO;
            
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    activeField = textField;
}
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _loginScrollView.contentInset = contentInsets;
    _loginScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [_loginScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _loginScrollView.contentInset = contentInsets;
    _loginScrollView.scrollIndicatorInsets = contentInsets;
}

@end
