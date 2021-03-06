//
//  Request.m
//  JiE
//
//  Created by Rajesh on 07/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "Request.h"
#import "UserDetail.h"
@implementation Request

-(void)createConnection:(NSMutableURLRequest *)postRequest{
    _urlConnecction = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self];
    if(_urlConnecction)
    {
        _webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
}

- (NSString *) timeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

-(void)getAllNotifications{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@jie/subjie.php?action=getnotification",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"senderId=%@",getUser().userId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

-(void)deleteNotification:(int)notificationId{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@jie/subjie.php?action=delnotification",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"notifyId=%d",notificationId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}


//Get all user
-(void)getAllUserForUser{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=getFriends",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@",getUser().userId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Get user with search
-(void)getUserForSearchString:(NSString *)string{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=getAllUsers",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"searchString=%@",string];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//AcceptFriend
-(void)addFriendWithFriendId:(NSString *)fid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=acceptFriend",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@&friendId=%@",getUser().userId,fid];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//AcceptFriend
-(void)sendFriendRequest:(NSString *)fid{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=sendFriendReq",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@&friendId=%@&message=%@",getUser().userId,fid,[NSString stringWithFormat:@"%@ send a friend request.",getUser().username]];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Get post
-(void)getAllJie{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=retrive",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@",getUser().userId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

////////////////////
-(void)getMyJIE{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=getpost",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userid=%@",getUser().userId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

///////////////////

//GetComments
-(void)getComments:(NSString *)postId{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=getComment",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"postId=%@",postId];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//PostComment
-(void)postComments:(NSString *)postId comment:(NSString *)comment{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=addComment",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"postId=%@&userId=%@&comment=%@&time=%@",postId,getUser().userId,comment,TimeStamp];
    NSData *body = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:body];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//SignUp
-(void)signUp:(NSString *)username email:(NSString *)email password:(NSString *)password profilePic:(NSString *)profilePic dob:(NSString *)dob device:(NSString *)deviceToken{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subscriber.php?action=register",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"username=%@&email=%@&pass=%@&profilepic=%@&dob=%@&deviceToken=%@",username,email,password,profilePic,dob,deviceToken];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

-(void)siupWithTwitter:(NSString *)userId userName:(NSString *)userName decive:(NSString *)deviceToken{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subscriber.php?action=registerWithTwitter",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@&username=%@&deviceToken=%@",userId,userName,deviceToken];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}
-(void)siupWithFacebook:(NSString *)userId userName:(NSString *)userName userEmail:(NSString *)email decive:(NSString *)deviceToken{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subscriber.php?action=registerWithFB",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userId=%@&email=%@&username=%@&deviceToken=%@",userId,email,userName,deviceToken];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Forgot password
-(void)resetPasswordWithEmail:(NSString *)email
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/sub.php?action=pwd",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"email=%@",email];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

-(void)updateDeviceToken:(NSString *)deviceToken WithUserId:(NSString *)userId{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=updateDevice",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"userID=%@&deviceToken=%@&deviceID=iOS",userId,deviceToken];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Login
-(void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subscriber.php?action=login",Notification_Server_domain]];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"email=%@&pass=%@",userName,password];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Method to add Jie into server
-(void)addJieWithParameter:(JieClass *)jObj{
   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/jie/subjie.php?action=addjie",Notification_Server_domain]];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:45.0];
    [postRequest setValue:@"900" forHTTPHeaderField:@"Keep-Alive"];
    [postRequest setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [postRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //UserId
    if (jObj.userid.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"userid\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.userid] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.userEmail.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"user_email\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.userEmail] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.username.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"username\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.username] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.title.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"title\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.title] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.des.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"des\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.des] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.video != nil && jObj.video.length>0) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_video_file\"; filename=\"%@.mov\"\r\n",TimeStamp] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:jObj.video]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.image != nil && jObj.image.length>0) {
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_image_file\"; filename=\"%@.png\"\r\n",TimeStamp] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:jObj.image]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.result.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"result\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.result] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.privacy.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"privacy\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.privacy] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.salary > 0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"salary\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%f",jObj.salary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.cost > 0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"cost\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%f",jObj.cost] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.time.length>0) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str=@"Content-Disposition: form-data; name=\"time\"\r\n\r\n";
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",jObj.time] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (jObj.profilepic != nil && jObj.profilepic.length>0) {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file_thumb\"; filename=\"%@.png\"\r\n",TimeStamp] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:jObj.profilepic]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postRequest setHTTPBody:body];
    [self createConnection:postRequest];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _urlConnecction=nil;
    if (_delegate != nil && [_delegate respondsToSelector:@selector(getError)]) {
        [_delegate getError];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[_webData length]);
    NSString *jsonString = [[NSString alloc] initWithData:_webData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString = %@",jsonString);
    id responseData = [NSJSONSerialization JSONObjectWithData:_webData options:NSJSONReadingMutableContainers error:nil];;
    _urlConnecction=nil;
    NSLog(@"response = %@",[responseData description]);
    if (responseData != nil) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(getResult:)]) {
            [_delegate getResult:responseData];
        }
    }
    else
    {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(getError)]) {
            [_delegate getError];
        }
    }
}
-(void)dealloc{
    _delegate = nil;
}
@end
