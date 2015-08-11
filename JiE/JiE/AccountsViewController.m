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
    
      [super viewDidLoad];
    
    NSString *MYString =[[NSUserDefaults standardUserDefaults]
                         stringForKey:@"USER_NAME_1"];
    
    ////////////////////////////////////////////////////////
    
  if (MYString.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            UIImage *profileimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:MYString]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.profilePic.image = profileimage;
                
                //[cell setNeedsLayout];
                
            });
        });
    }


    
    
    ///////////////////////////////////////////////////////////
    
    
    
    self.txtField.text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_NAME"];
    
    self.txtDOB
    .text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_DOB"];
    
    
    self.txtEmail.text=[[NSUserDefaults standardUserDefaults]
                      stringForKey:@"USER_EMAIL"];
    
 
    
  
    
    
    
    NSLog(@"MMMYYYYYYUUUUUIIIIIIII%@ %@ %@",
    [[NSUserDefaults standardUserDefaults]
     stringForKey:@"USER_EMAIL"],[[NSUserDefaults standardUserDefaults]
                                  stringForKey:@"USER_NAME"],[[NSUserDefaults standardUserDefaults]
                                                              stringForKey:@"USER_NAME_1"],[[NSUserDefaults standardUserDefaults]
                                                stringForKey:@"USER_DOB"]);

   
}


- (IBAction)buttonPress:(id)sender {
}






@end
