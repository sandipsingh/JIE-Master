//
//  NotificationsViewController.h
//  JiE
//
//  Created by Rajesh on 12/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notificationTableViewCell.h"
#import "Request.h"
typedef enum NotificationsRequest{
    getAllNotifications = 0,
    deleteNotifications
}NotificationsRequest;


@interface NotificationsViewController : UITableViewController<notificationDelegate,RequestDelegate>

@property(nonatomic, strong) NSMutableArray *notificationsArray;

@property (nonatomic, assign) NotificationsRequest requestType;

@property (nonatomic, assign) int rowNumber;

@end
