//
//  Common.h
//  JiE
//
//  Created by Rajesh on 26/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDetail.h"
inline static UserDetail * getUser()
{
    UserDetail *obj = nil;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *userData = [prefs objectForKey:UserDetails];
    
    if ((userData.length>0)&&(userData!= nil )){
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
    }
    if (userData != nil) {
        userData = nil;
    }
    return obj;
}
inline static void  saveUserData (UserDetail* obj)
{
    NSUserDefaults *userDefault= [NSUserDefaults standardUserDefaults];
    NSData *objData = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [userDefault setObject:objData forKey:UserDetails];
    [userDefault synchronize];
}