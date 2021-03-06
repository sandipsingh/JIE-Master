//
//  Request.h
//  JiE
//
//  Created by Rajesh on 07/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JieClass.h"
@protocol RequestDelegate<NSObject>
-(void)getResult:(id)response;
-(void)getError;
@end
@interface Request : NSObject
@property(nonatomic,weak) id<RequestDelegate> delegate;
@property(nonatomic,strong) NSURLConnection *urlConnecction;
@property(nonatomic,strong) NSMutableData *webData;
-(void)addJieWithParameter:(JieClass *)jObj;
-(void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password;
-(void)resetPasswordWithEmail:(NSString *)email;
-(void)signUp:(NSString *)username email:(NSString *)email password:(NSString *)password profilePic:(NSString *)profilePic dob:(NSString *)dob device:(NSString *)deviceToken;
-(void)getAllJie;
-(void)getAllUserForUser;
-(void)getUserForSearchString:(NSString *)str;
-(void)addFriendWithFriendId:(NSString *)fid;
-(void)getComments:(NSString *)postId;
-(void)postComments:(NSString *)postId comment:(NSString *)comment;
-(void)sendFriendRequest:(NSString *)fid;
-(void)updateDeviceToken:(NSString *)deviceToken WithUserId:(NSString *)userId;
-(void)deleteNotification:(int)notificationId;
-(void)getAllNotifications;
-(void)siupWithTwitter:(NSString *)userId userName:(NSString *)userName decive:(NSString *)deviceToken;
-(void)siupWithFacebook:(NSString *)userId userName:(NSString *)userName userEmail:(NSString *)email decive:(NSString *)deviceToken;
-(void)getMyJIE;
@end
