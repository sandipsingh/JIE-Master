//
//  CommentsViewController.m
//  JiE
//
//  Created by Rajesh on 27/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "CommentsViewController.h"
#import "commentsTableViewCell.h"
#import "Comments.h"
@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Comments";
    _commentsArray = [[NSMutableArray alloc] init];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClick)];
    [self.navigationController.navigationItem setRightBarButtonItem:rightBar];
    // Do any additional setup after loading the view.
}
-(void)doneClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getComments];
}
-(void)getError{
    [_HUD hide:YES];
}
-(void)getResult:(id)response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        if (_cReq == getComments) {
            [_commentsArray removeAllObjects];
            NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:response];
            id result = [resultDic valueForKey:@"result"];
            if ([result  isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)result;
                for (int i = 0; i<[array count]; i++) {
                    NSDictionary *innerDic = [array objectAtIndex:i];
                    Comments *obj = [[Comments alloc] init];
                    obj.userName = [innerDic valueForKey:@"userName"];
                    obj.comment = [innerDic valueForKey:@"comment"];
                    [_commentsArray addObject:obj];
                }
            }
        }
        [_tblView reloadData];
        }
    [_HUD hide:YES];
}

-(void)postComment{
    if (_txtComment.text.length>0) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        [_HUD show:YES];
        
        Request *req = [[Request alloc] init];
        req.delegate = self;
        [req postComments:_postId comment:_txtComment.text];
    }
}
-(void)getComments{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    [_HUD show:YES];
    
    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getComments:_postId];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_commentsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"commentsTableViewCell";
    
    commentsTableViewCell *cell = (commentsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[commentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Comments *obj = [_commentsArray objectAtIndex:indexPath.row];
    cell.lblUserName.text = obj.userName;
    cell.lblComment.text = obj.comment;
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    return cell;
}
- (IBAction)sendComment:(id)sender {
    [self postComment];
}
@end
