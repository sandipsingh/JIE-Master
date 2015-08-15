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

@interface ViewController ()

@end

@implementation ViewController
-(void)getError{
    
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
-(void)SignUpWithTwitter:(TWTRSession *)session{
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj signUp:session.userName email:@"" password:@"" profilePic:@"" dob:@""];
}
-(void)SignUpWithFaceBook:(id<FBGraphUser>)user{
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    //user.id
    [reqObj signUp:user.name email:[user objectForKey:@"email"] password:@"" profilePic:@"" dob:@""];
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
    [self SignUpWithFaceBook:user];
}
-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}
@end
