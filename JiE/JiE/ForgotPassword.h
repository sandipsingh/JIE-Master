//
//  ForgotPassword.h
//  JiE
//
//  Created by neeraj on 01/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@interface ForgotPassword : NSObject<RequestDelegate>
@property(strong,nonatomic) NSMutableData *responseData;
- (void)forgotPasswordWebService:(NSString*) email;

@end
