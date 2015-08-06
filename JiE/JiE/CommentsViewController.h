//
//  CommentsViewController.h
//  JiE
//
//  Created by Rajesh on 27/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Request.h"
typedef enum {
    getComments = 0,
    postComment
} commentOperations;
@interface CommentsViewController : UIViewController<RequestDelegate>


@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (assign, nonatomic) commentOperations cReq;
@property (weak, nonatomic) IBOutlet UITextField *txtComment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraints;

- (IBAction)sendComment:(id)sender;
@end
