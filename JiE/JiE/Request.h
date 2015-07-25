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
@end
@interface Request : NSObject
@property(nonatomic,assign) id<RequestDelegate> delegate;
@property(nonatomic,strong) NSURLConnection *urlConnecction;
@property(nonatomic,strong) NSMutableData *webData;
-(void)addJieWithParameter:(JieClass *)jObj;
-(void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password;
-(void)resetPasswordWithEmail:(NSString *)email;
-(void)signUp:(NSString *)username email:(NSString *)email password:(NSString *)password profilePic:(NSString *)profilePic dob:(NSString *)dob;
-(void)getAllJie;
@end
