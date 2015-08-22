//
//  NotificationsViewController.m
//  JiE
//
//  Created by Rajesh on 12/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "NotificationsViewController.h"
#import "notificationTableViewCell.h"
#import "Notifications.h"
@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

-(void)getError{
    NSLog(@"Error");
}
-(void)getResult:(id)response{
    switch (_requestType) {
        case getAllNotifications:
        {
            id resultValue = [response valueForKey:@"result"];
            if ([resultValue isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)resultValue;
                for (int i = 0; i< [array count]; i++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    Notifications *obj = [[Notifications alloc] init];
                    obj.comment = [dic valueForKey:@"message"];
                    obj.senderId = [[dic valueForKey:@"senderId"] intValue];
                    obj.profileImagePath = [dic valueForKey:@"profilepic"];
                    obj.time = [dic valueForKey:@"time"];
                    obj.notificationId = [[dic valueForKey:@"notifyId"] intValue];
                    [_notificationsArray addObject:obj];
                }
            }
            [self.tableView reloadData];
        }
            break;
        case deleteNotifications:
        {
            id resultValue = [response valueForKey:@"result"];
            
            if ([resultValue boolValue] == true)
            {
                [_notificationsArray removeObjectAtIndex:_rowNumber];
                [self.tableView reloadData];
            }
        }
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Notifications";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getNotificatios];
    [super viewWillAppear:animated];
}
-(void)getNotificatios{
    _requestType = getAllNotifications;
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj getAllNotifications];
}

-(void)deleteNotifications:(int)notificationId{
    _requestType = deleteNotifications;
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj deleteNotification:notificationId];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_notificationsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)showAlertWithFriendRequest:(Notifications *)obj {
    _fId = [NSString stringWithFormat:@"%d",obj.senderId];
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        
        UIAlertController *actionView = [UIAlertController alertControllerWithTitle:nil message:obj.comment preferredStyle:UIAlertControllerStyleAlert];
        
        
            UIAlertAction* Reject = [UIAlertAction
                                  actionWithTitle:@"Reject"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      _fId = nil;
                                  }];
            [actionView addAction:Reject];
            UIAlertAction* Accept = [UIAlertAction
                                 actionWithTitle:@"Accept"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self acceptFriendRequest];
                                 }];
        
         [actionView addAction:Accept];
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:obj.comment delegate:self cancelButtonTitle:@"Reject" otherButtonTitles:@"Accept", nil];
        [alertView show];
    }
}

-(void)acceptFriendRequest{
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req addFriendWithFriendId:_fId];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
        {
            [self acceptFriendRequest];
        }
            break;
        case 0:
        {
            _fId = nil;
        }
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Notifications *obj = [_notificationsArray objectAtIndex:indexPath.row];
    if ([obj.comment rangeOfString:@"friend"].length>0) {
        //show popup for acceptFriend request
        [self showAlertWithFriendRequest:obj];
    }
    else{
        //show popup for show comment
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"HomeTableViewCell";
    
    notificationTableViewCell *cell = (notificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[notificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Notifications *obj = [_notificationsArray objectAtIndex:indexPath.row];
    cell.rowIndex = indexPath.row;
    cell.lblcomment.text = obj.comment;
    cell.imgProfile.image = [UIImage imageNamed:obj.profileImagePath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    return cell;
}
-(void)didSelectItemAtIndex:(NSInteger)row{
    _rowNumber = (int)row;
    Notifications *obj = [_notificationsArray objectAtIndex:row];
    [self deleteNotifications:obj.notificationId];
}
@end
