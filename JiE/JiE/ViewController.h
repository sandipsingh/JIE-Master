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
@interface ViewController : UIViewController<RequestDelegate>
@property(strong,nonatomic) UINavigationController *localNavigationController123;

@property (weak, nonatomic) IBOutlet TWTRLogInButton *logInButton;

@end

