//
//  FriendsViewController.m
//  JiE
//
//  Created by vikas on 25/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsTableViewCell.h"
#import "UserDetail.h"
@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)getResult:(id)response{
    switch (_fReq) {
        case getMyFriendList:
        case getUserBySearch:
        {
            if ([response isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)response;
                for (int i = 0; i< [array count]; i++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    UserDetail *obj = [[UserDetail alloc] init];
                    obj.dob = [dic objectForKey:@"dob"];
                    obj.email = [dic objectForKey:@"email"];
                    obj.userId = [dic objectForKey:@"id"];
                    obj.profilepic = [dic objectForKey:@"profilepic"];
                    obj.username = [dic objectForKey:@"username"];
                    if (_fReq == getMyFriendList) {
                        [_myFriendsArray addObject:obj];
                    }
                    else{
                         [_usersArray addObject:obj];
                    }
                }
                [_tblView reloadData];
            }
        }
            break;
        case addFriendWithFriendId:{
            
        }
            break;
            
        default:
            break;
    }
}
-(void)getError{
    NSLog(@"getError");
}
-(void)getMyFriendList{
    _fReq = getMyFriendList;
    [_myFriendsArray removeAllObjects];
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getAllUserForUser];
}
-(void)getUserBySearch:(NSString *)search{
    [_usersArray removeAllObjects];
    _fReq = getUserBySearch;
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getAllUserForUser];
}
-(void)addFriendWithFriendId:(NSString *)fid{
    _fReq = addFriendWithFriendId;
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req addFriendWithFriendId:fid];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_fReq == getMyFriendList) {
        return [_myFriendsArray count];
    }
    return [_usersArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"FriendsTableViewCell";
    
    FriendsTableViewCell *cell = (FriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UserDetail *obj = nil;
    if (_fReq == getMyFriendList) {
        obj = [_myFriendsArray objectAtIndex:indexPath.row];
    }
    else{
        obj = [_usersArray objectAtIndex:indexPath.row];
    }
    cell.lblFname.text = obj.username;
    
    if (obj.profilepic.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.profilepic]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imgFriend.image = image;
                [cell setNeedsLayout];
            });
        });
    }
    else{
        cell.imgFriend.image = nil;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
