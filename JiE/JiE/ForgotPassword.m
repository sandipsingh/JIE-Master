//
//  ForgotPassword.m
//  JiE
//
//  Created by neeraj on 01/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "ForgotPassword.h"

@implementation ForgotPassword

- (void)forgotPasswordWebService:(NSString*) email
{
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;
    [reqObj resetPasswordWithEmail:email];
}
-(void)getResult:(id)response
{
    if ([response isKindOfClass:[NSArray class]]) {
        for(NSDictionary *dict in response) {
            BOOL result = [[dict objectForKey:@"result"] boolValue];
            NSLog(@" This is JSON resp[onse-2 %d",result);
        }
    }
}
@end
