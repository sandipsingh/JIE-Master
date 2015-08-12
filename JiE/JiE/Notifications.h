//
//  Notifications.h
//  JiE
//
//  Created by Rajesh on 12/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notifications : NSObject
@property (nonatomic, assign) int notificationId;
@property (nonatomic, assign) int userId;
@property (nonatomic, assign) int senderId;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *profileImagePath;
@property (nonatomic,strong) NSDate *time;
@end
