//
//  UserDetail.h
//  JiE
//
//  Created by Rajesh on 26/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetail : NSObject<NSCoding>
@property(strong,nonatomic) NSString *dob;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *profilepic;
@property(strong,nonatomic) NSString *username;
@end
