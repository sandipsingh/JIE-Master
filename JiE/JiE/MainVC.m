//
//  MainVC.m
//  JiE
//
//  Created by neeraj on 02/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "MainVC.h"
#import "AppDelegate.h"
@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)logOut{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserDetails];
    UINavigationController *mainVCObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstView"];
    [((AppDelegate *)[UIApplication sharedApplication].delegate).window setRootViewController:mainVCObj];
    [((AppDelegate *)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath

{
    NSString *identifier = @"";
    
    NSLog(@"indexPath = %ld", (long)indexPath.row);
    switch (indexPath.row) {
        case 0:
            identifier = @"firstSegue";
            break;
        case 1:
            identifier = @"firstSegue";
            break;
        case 2:
            identifier = @"secondSegue";
            break;
        case 3:
            identifier = @"thirdSegue";
            break;
            case 4:
           identifier = @"fourthSegue";
            break;
        case 5:
            identifier = @"fifthSegue";
            break;
        case 6:
            identifier = @"sixthSegue";
            break;
        case 7:
            identifier = @"";
            break;
        case 8:
        {
            [self logOut];
        }
            break;
    }
    
    return identifier;
}



- (void)configureLeftMenuButton:(UIButton *)button

{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 28, 20);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
}

@end
