//
//  JieClass.h
//  JiE
//
//  Created by Rajesh on 07/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JieClass : NSObject


@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *userEmail;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *des;
@property(nonatomic,strong) NSData *video;
@property(nonatomic,strong) NSData *image;
@property(nonatomic,strong) NSString *result;
@property(nonatomic,strong) NSString *privacy;
@property(nonatomic,assign) float salary;
@property(nonatomic,assign) float cost;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSData *profilepic;
@end
