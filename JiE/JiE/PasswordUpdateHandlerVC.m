//
//  PasswordUpdateHandlerVC.m
//  JiE
//
//  Created by vikas on 13/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "PasswordUpdateHandlerVC.h"

@interface PasswordUpdateHandlerVC ()

@end

@implementation PasswordUpdateHandlerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}






- (void)changePasswordWebService
{
    NSString *email       = self.userEmail.text;
    NSString *oldPassword = self.userOldPassword.text;
    NSString *newPassword = self.userNewPassword.text;
    
    
    //NSString *email       = @"ram@avigma.com";
   // NSString *oldPassword = @"12345";
   // NSString *newPassword =  @"123456";
   
    
    NSString *changePassswordURLString = [NSString stringWithFormat:@"http://www.support-4-pc.com/clients/jie/sub.php?action=pwd"];
    
    
    self.responseData = [NSMutableData data];
    

    NSString *parameterStringInRequestBody = [NSString stringWithFormat:@"email=%@&pass=%@&password=%@",email,oldPassword, newPassword];
  
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:changePassswordURLString]];
    [request setHTTPBody:POSTData];
    [request setHTTPMethod:@"POST"];
    NSLog(@"request is this %@",request);
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    id connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
        self.responseData = [NSMutableData data];
    else
        NSLog(@"theConnection is NULL");
}

#pragma mark-
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
    //  isDownloading= YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //if (isDownloading) {
    [self.responseData appendData:data];
    //}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseData = nil;
    
    NSString *errorDescription = @"";
    NSDictionary *errorDict = error.userInfo;
    if([[errorDict allKeys] containsObject:@"NSLocalizedDescription"]) {
        errorDescription = [errorDict objectForKey:@"NSLocalizedDescription"];
        
    } else {
        errorDescription = @"Network Failed To Respond";
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //****************Initilize arrays for values**************
    NSLog(@"%@",connection);
    NSDictionary * jsonArray= [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@" AAAAMMMMPPPPP-2 %@",jsonArray);
    
    
            NSString  * responseFromServer = [jsonArray objectForKey:@"result"];
            NSLog(@"This is TRUE%@",responseFromServer);
    
   
    
    
}




- (IBAction)submitBotton:(id)sender {
    [self changePasswordWebService];
}
@end
