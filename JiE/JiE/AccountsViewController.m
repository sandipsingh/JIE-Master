//
//  AccountsViewController.m
//  JiE
//
//  Created by vikas on 25/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "AccountsViewController.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCoupansWebservice];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonPress:(id)sender {
}


- (void)getCoupansWebservice
{
    
    NSString *weeklySpecialURLString = [NSString stringWithFormat:@"http://www.support-4-pc.com/clients/jie/subscriber.php?action=login"];
    
    self.responseData = [NSMutableData data];
   
    
    NSString *parameterStringInRequestBody =[NSString stringWithFormat:@"email=ritika@gmail.com&pass=123"];
    
    NSData *POSTData = [parameterStringInRequestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:weeklySpecialURLString]];
    [request setHTTPBody:POSTData];
    [request setHTTPMethod:@"POST"];
    NSLog(@"request is this %@",request);
    //  [request addValue: @"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    // [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:API_KEY forHTTPHeaderField:@"TK-API-KEY"];
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
    NSDictionary* jsonDict= [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    
    
    NSLog(@"YOOO MY TABLE %@",jsonDict);
   
    //[HUD hide:YES];
    //Setting the checkin ID for facebook View Controller
    //Setting user email id in defaults
    
}





@end
