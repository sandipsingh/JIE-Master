//
//  HomeViewController.m
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "JieModel.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    _jieArray = [[NSMutableArray alloc] init];
    [self getJie];
    // Do any additional setup after loading the view.
}
-(void)getResult:(id)response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        [_jieArray removeAllObjects];
        NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:response];
        id result = [resultDic valueForKey:@"result"];
        if ([result  isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i = 0; i<[array count]; i++) {
                NSDictionary *innerDic = [array objectAtIndex:i];
                JieModel *obj = [[JieModel alloc] init];
                obj.jieId = [innerDic valueForKey:@"id"];
                obj.userId = [innerDic valueForKey:@"userid"];
                obj.username = [innerDic valueForKey:@"username"];
                obj.title = [innerDic valueForKey:@"title"];
                obj.jieDescription = [innerDic valueForKey:@"des"];
                obj.jieImageURL = [innerDic valueForKey:@"image"];
                obj.jieVideoURL = [innerDic valueForKey:@"video"];
                obj.privacy = [innerDic valueForKey:@"privacy"];
                obj.result = [innerDic valueForKey:@"result"];
                obj.thumbImageURL = [innerDic valueForKey:@"thumb_image"];
                obj.time = [innerDic valueForKey:@"time"];
                obj.imgTag = [innerDic valueForKey:@"img_tag"];
                obj.videoTag = [innerDic valueForKey:@"video_tag"];
                [_jieArray addObject:obj];
            }
        }
    }
    [_HUD hide:YES];
    [_tblView reloadData];
}
-(void)getJie{
    _HUD= [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    [_HUD show:YES];

    Request *req = [[Request alloc] init];
    req.delegate = self;
    [req getAllJie];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [_jieArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"HomeTableViewCell";
    
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    JieModel *obj = [_jieArray objectAtIndex:indexPath.row];
    cell.lbluserName.text = obj.username;
    cell.lblTitle.text = obj.title;
    cell.lblDescription.text = obj.jieDescription;
   // cell.lblLastSeen.text = obj.time;
    
    if (obj.jieImageURL.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.jieImageURL]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imgPost.image = image;
                [cell setNeedsLayout];
            });
        });
    }
    else{
        cell.imgPost.image = nil;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2 == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else{
         cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
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

@end
