//
//  ViewController.m
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "JieClass.h"
#import "Request.h"
#import "MainVC.h"
#import "MBProgressHUD.h"
@interface ViewController ()
@property(nonatomic,strong) MBProgressHUD *loadingView;
@end

@implementation ViewController
-(void)getError{
    [_loadingView hide:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Validation" message:@"Some error occured. Please try again" delegate:nil //or self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

-(void)getFacebookProfileInfos {
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:nil];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if(result)
        {
            if ([result objectForKey:@"email"]) {
                NSLog(@"Email: %@",[result objectForKey:@"email"]);
            }
            if ([result objectForKey:@"name"]) {
                NSLog(@"First Name : %@",[result objectForKey:@"name"]);
            }
            if ([result objectForKey:@"id"]) {
                NSLog(@"User id : %@",[result objectForKey:@"id"]);
            }
              [self SignUpWithFaceBook:result];
        }
    }];
    [connection start];
}
- (IBAction)loginWithFacebook:(id) sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile",@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            // Login Successful here
            
            // Check for any particular permissions you asked
            if ([result.grantedPermissions containsObject:@"email"]) {
                [self getFacebookProfileInfos];
            }
        }
    }];
}
-(void)showLoading{
    _loadingView= [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_loadingView];
    [_loadingView show:YES];
}
-(void)SignUpWithTwitter:(TWTRSession *)session{
    [self showLoading];
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj siupWithTwitter:session.userID userName:session.userName decive:[[NSUserDefaults standardUserDefaults] objectForKey:pushtoken]];
}
-(void)SignUpWithFaceBook:(id)result{
    [self showLoading];
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj siupWithFacebook:[result objectForKey:@"id"] userName:[result objectForKey:@"name"] userEmail:[result objectForKey:@"email"] decive:[[NSUserDefaults standardUserDefaults] objectForKey:pushtoken]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.logInButton.readPermissions = @[@"public_profile", @"email"];
    //self.logInButton.delegate = self;
    
    _twitterlogInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession* session, NSError* error) {
        if (error != nil) {
            NSLog(@"error: %@", [error localizedDescription]);
            

        } else {
            NSLog(@"signed in as %@", [session userName]);
            [self SignUpWithTwitter:session];
        }
    }];
    [self.view addSubview:_twitterlogInButton];
    // Do any additional setup after loading the view, typically from a nib.
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
}

-(void)getResult:(id)response
{
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
        [_loadingView hide:YES];
        // redirection user to the app as per login status
        if(loginResult  == YES){
            MainVC *mainVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
            [self.navigationController pushViewController:mainVCObj animated:YES];
        }
        else{
            [self getError];
        }
    }
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _twitterlogInButton.frame = CGRectMake(_logInButton.frame.origin.x, _logInButton.frame.origin.y, _logInButton.frame.size.width, _logInButton.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
  
}
-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}
@end
