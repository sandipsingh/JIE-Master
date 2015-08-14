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
                    obj.comment = [dic valueForKey:@""];
                    obj.senderId = [[dic valueForKey:@""] intValue];
                    obj.profileImagePath = [dic valueForKey:@""];
                    obj.time = [dic valueForKey:@""];
                    obj.notificationId = [[dic valueForKey:@""] intValue];
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
