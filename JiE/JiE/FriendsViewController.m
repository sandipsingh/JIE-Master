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
    self.title = @"My Friend List";
    _myFriendsArray = [[NSMutableArray alloc] init];
    _usersArray = [[NSMutableArray alloc] init];
    [self getMyFriendList];
    // Do any additional setup after loading the view.
}

-(void)showLoading{
    _loadingView= [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_loadingView];
    [_loadingView show:YES];
}

-(void) removeLoading{
    [_loadingView hide:YES];
}
-(void)makeSearch{
    [self getUserBySearch:_txtSearch.text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length>0) {
        [self makeSearch];
    }else{
        _btnAddFriend.enabled = NO;
    }
    return YES;
}
-(void)getResult:(id)response{
    [self removeLoading];
    switch (_fReq) {
        case getMyFriendList:
        case getUserBySearch:
        {
            id resultValue = [response valueForKey:@"result"];
            if ([resultValue isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)resultValue;
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
                         _btnAddFriend.enabled = YES;
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
    [self removeLoading];
    NSLog(@"getError");
}

-(void)getMyFriendList{
    [self showLoading];
    _btnAddFriend.enabled = NO;
    _fReq = getMyFriendList;
    [_myFriendsArray removeAllObjects];
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getAllUserForUser];
}

-(void)getUserBySearch:(NSString *)search{
    [_usersArray removeAllObjects];
    [self showLoading];
    _fReq = getUserBySearch;
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getUserForSearchString:search];
}

-(void)addFriendWithFriendId:(NSString *)fid{
    [self showLoading];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserDetail *obj = nil;
    if (_fReq == getMyFriendList) {
        obj = [_myFriendsArray objectAtIndex:indexPath.row];
    }
    else{
        obj = [_usersArray objectAtIndex:indexPath.row];
        _friendId = obj.userId;
    }
    
}
-(void)sendFriendRequest{
    [self addFriendWithFriendId:_friendId];
}
- (IBAction)addFriend:(id)sender {
    [self sendFriendRequest];
}
@end
