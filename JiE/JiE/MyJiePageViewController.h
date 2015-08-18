

//
// MyJiePageViewController.h
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "MBProgressHUD.h"

@interface MyJiePageViewController : UIViewController<RequestDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property(strong,nonatomic) NSMutableArray *jieArray;
@property(strong,nonatomic) MBProgressHUD *HUD;



-(IBAction)openAddJie:(id)sender;
@end
