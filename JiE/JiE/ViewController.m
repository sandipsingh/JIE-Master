//
//  ViewController.m
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "ViewController.h"

#import "JieClass.h"
#import "Request.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)getError{
    
}
-(void)SignUpWithTwitter:(TWTRSession *)session{
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj signUp:session.userName email:@"" password:@"" profilePic:@"" dob:@""];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
