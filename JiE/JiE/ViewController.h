//
//  ViewController.h
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import <TwitterKit/TwitterKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface ViewController : UIViewController<RequestDelegate,FBLoginViewDelegate>
@property(strong,nonatomic) UINavigationController *localNavigationController123;
@property (weak, nonatomic) IBOutlet UIView *startingView;

@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet FBLoginView *FBLogInButton;
@property (strong,nonatomic) TWTRLogInButton *twitterlogInButton;
- (IBAction)loginWithFacebook:(id)sender;

@end

