//
//  SignUpVC.m
//  JiE
//
//  Created by neeraj on 24/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "SignUpVC.h"
#import "MBProgressHUD.h"
#import "MainVC.h"
@interface SignUpVC (){
    UIImage *newImage;
    NSString *signInURLString;
    MBProgressHUD *HUD;
    NSString *imageIn64;
    UIDatePicker* picker;
}
@end

@implementation SignUpVC

-(void)getError{
    [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Some error occured. Please try again" delegate:nil //or self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[UIButton buttonWithType:UIButtonTypeSystem];
    imageIn64=nil;
    
    //Making navigation bar transparent only back button is displayed
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0 green:255 blue:0 alpha:.4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)imagePicker:(id)sender

{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo

{
    [picker dismissModalViewControllerAnimated:YES];
    
    newImage = image;
    
    [self.imagePickerOutLet setImage:newImage forState:UIControlStateNormal];
    //Converting in base 64
    
    imageIn64 =[self encodeToBase64String:newImage];
    NSLog(@"This is ImageIn 64%@",imageIn64);
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
//****************************** Web Service call *************************

//*******************************************WEB SERVICE CALLING SECTION***********************

- (void)registerUserWebService
{
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj signUp:self.userName_OutLet.text email:self.email_OutLet.text password:self.passw0rd_OutLet.text profilePic:imageIn64 dob:self.DOB_Outlet.text device:[[NSUserDefaults standardUserDefaults] objectForKey:pushtoken]];
}
-(void)getResult:(id)response{
    
    BOOL loginResult = NO;
    if ([response isKindOfClass:[NSArray class]]) {
        for(NSDictionary *dict in response) {
            loginResult = [[dict objectForKey:@"result1"] boolValue];
            id result = [dict objectForKey:@"result2"];
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
                    [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"email"] forKey:@"USER_EMAIL"];
                    [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"dob"] forKey:@"USER_DOB"];
                    [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"username"] forKey:@"USER_NAME"];
                    [[NSUserDefaults standardUserDefaults] setObject: [dic objectForKey:@"profilepic"]forKey:@"USER_NAME_1"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        
                        NSURL *profileURL = [NSURL URLWithString:[obj.profilepic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    break;
                }
            }
        }
        [HUD hide:YES];
        // redirection user to the app as per login status
        if(loginResult  == YES){
            MainVC *mainVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
            [self.navigationController pushViewController:mainVCObj animated:YES];
        } else{
            [self getError];
        }
    }
}
-(void)validateSignUP
{
    if([self.userName_OutLet.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter username" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([self.email_OutLet.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter email" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([self.passw0rd_OutLet.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter password" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([self.DOB_Outlet.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter DOB" delegate:nil //or self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    
    else if (![self.email_OutLet.text isEqualToString:@""]){
        
        
        NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        NSString *errorMessage;
        errorMessage=nil;
        if (![emailPredicate evaluateWithObject:self.email_OutLet.text]){
            [self.email_OutLet becomeFirstResponder];
            errorMessage= @"Please enter a valid email address";
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Please enter valid Email" delegate:nil //or self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            [alert show];
        }
        
        else{
            [self registerUserWebService];
            HUD= [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            [HUD show:YES];
        }
    }
}

- (IBAction)button_SignUP:(id)sender {
    [self validateSignUP];
    
}

//text field delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)btn:(id)sender {
    
}

- (IBAction)DOB_Action:(id)sender {
    [self.DOB_Outlet resignFirstResponder];
    picker = [[UIDatePicker alloc] init];
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.datePickerMode = UIDatePickerModeDate;
    [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
    picker.frame = CGRectMake(0.0, 250, pickerSize.width, 120);
    picker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picker];
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    self.DOB_Outlet.text=[dateFormatter stringFromDate:[sender date]];
    //[self.userName_OutLet reg];
    [self.userName_OutLet becomeFirstResponder];
    [self.userName_OutLet resignFirstResponder];
    [picker removeFromSuperview];
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    // Here You can do additional code or task instead of writing with keyboard
//
////    [self.DOB_Outlet resignFirstResponder];
//    return NO;
//}



@end

