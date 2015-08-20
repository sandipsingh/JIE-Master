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
    
    
    ////////////////////////////
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 5;
   // self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 14;
    self.profilePic.clipsToBounds = YES;
    
    //To give the Border and Border color of imageview
    
   self.profilePic.layer.borderWidth = 1.0f;
   //self.profilePic.layer.borderColor = [UIColor colorWithRed:249/255.0f green:117/255.0f blue:44/255.0f alpha:1.0f].CGColor;
    
    //self.profilePic.layer.borderColor = [UIColor greenColor].CGColor;
    //self.profilePic.layer.borderWidth = 1.f;
    
    ///////////////////////////
    
    
    
    
    
   // self.profilePic.layer.cornerRadius = 10.0f;
    
   // UIImage *PROFILEdEGAULTiMAGE = [UIImage imageNamed:@"profile_Image_account"    ];
   // self.profilePic.image = PROFILEdEGAULTiMAGE;
      [super viewDidLoad];
    
 
    
    //////////////////////////////////
    
    NSString *MYString =[[NSUserDefaults standardUserDefaults]
                         stringForKey:@"USER_NAME_1"];
    
   

    
    ////////////////////////////////////////////////////////
    
  if (MYString.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            UIImage *profileimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:MYString]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.profilePic.image = profileimage;
          // [cell setNeedsLayout];
            
       
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


- (IBAction)editTextButton:(id)sender {
}

- (IBAction)changePasswordButton:(id)sender {
}

- (IBAction)buttonPress:(id)sender {
}






@end
