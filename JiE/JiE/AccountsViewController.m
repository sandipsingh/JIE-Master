//
//  AccountsViewController.m
//  JiE
//
//  Created by vikas on 25/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "AccountsViewController.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    self.txtField.text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_NAME"];
    
    self.txtDOB
    .text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_DOB"];
    
    
    self.txtEmail.text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_EMAIL"];
    
    
    [super viewDidLoad];
    
    
    
    NSLog(@"MMMYYYYYYUUUUUIIIIIIII%@ %@ %@",
    [[NSUserDefaults standardUserDefaults]
     stringForKey:@"USER_EMAIL"],[[NSUserDefaults standardUserDefaults]
                                  stringForKey:@"USER_NAME"],[[NSUserDefaults standardUserDefaults]
                                                               stringForKey:@"USER_DOB"]);

   
}


- (IBAction)buttonPress:(id)sender {
}






@end
