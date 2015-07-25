//
//  Request.m
//  JiE
//
//  Created by Rajesh on 07/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "Request.h"
#import "JSONKit.h"
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

-(void)getAllJie{
    NSURL *url = [NSURL URLWithString:@"http://www.support-4-pc.com/clients/jie/sub.php?action=retrive"];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:nil];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

-(void)signUp:(NSString *)username email:(NSString *)email password:(NSString *)password profilePic:(NSString *)profilePic dob:(NSString *)dob{
    NSURL *url = [NSURL URLWithString:@"http://www.support-4-pc.com/clients/jie/subscriber.php?action=register"];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"username=%@&email=%@&pass=%@&profilepic=%@&dob=%@",username,email,password,profilePic,dob];
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
    NSURL *url = [NSURL URLWithString:@"http://www.support-4-pc.com/clients/jie/sub.php?action=pwd"];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"email=%@",email];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
}

//Login
-(void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password{
    NSURL *url = [NSURL URLWithString:@"http://www.support-4-pc.com/clients/jie/subscriber.php?action=login"];
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"email=%@&pass=%@",userName,password];
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPBody:POSTData];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self createConnection:postRequest];
    
}

// Method to add Jie into server
-(void)addJieWithParameter:(JieClass *)jObj{
   NSURL *url = [NSURL URLWithString:@"http://www.support-4-pc.com/clients/jie/subjie.php?action=addjie"];
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
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_video_file\"; filename=\"%@.MOV\"\r\n",TimeStamp] dataUsingEncoding:NSUTF8StringEncoding]];
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
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[_webData length]);
    
    NSStringEncoding responseEncoding = NSUTF8StringEncoding;
    
    NSString *jsonString = [[NSString alloc] initWithData:_webData encoding:responseEncoding];
    
    NSLog(@"jsonString=%@",jsonString);
    
    id responseData= [NSJSONSerialization JSONObjectWithData:_webData options:NSJSONReadingMutableContainers error:nil];;
    
    _urlConnecction=nil;
    
    NSLog(@"%@",[responseData description]);
    if (responseData!=nil) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(getResult:)]) {
            [_delegate getResult:responseData];
        }
    }
    else
    {
    }
}
@end
