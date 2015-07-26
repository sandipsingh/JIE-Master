//
//  FriendsViewController.h
//  JiE
//
//  Created by vikas on 25/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "MBProgressHUD.h"
typedef enum {
    getMyFriendList = 0,
    getUserBySearch,
    addFriendWithFriendId
} friendRequest;

@interface FriendsViewController : UIViewController<RequestDelegate>
@property (strong,nonatomic) MBProgressHUD *loadingView;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnAddFriend;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (assign, nonatomic) friendRequest fReq;
@property (strong, nonatomic) NSMutableArray *myFriendsArray;
@property (strong, nonatomic) NSMutableArray *usersArray;

@property (strong, nonatomic) NSString *friendId;
- (IBAction)addFriend:(id)sender;
@end
