//
//  NewHomeViewController.m
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "NewHomeViewController.h"
#import "NewHomeTableViewCell.h"
#import "HomeTableViewCell.h"
#import "CommentsViewController.h"
#import "JieModel.h"
#import "AddJieViewController.h"
@interface NewHomeViewController ()

@end

@implementation NewHomeViewController

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    self.title = @"My JIE";
    _jieArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getJie];
    
     //NSLog(@"imgUserImage = %@",@"Privacy.png");
}

-(void)getError{
    NSLog(@"getError");
    [_HUD hide:YES];
}

-(void)getResult:(id)response{
    if ([response isKindOfClass:[NSDictionary class]]) {
        [_jieArray removeAllObjects];
        NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:response];
        id result = [resultDic valueForKey:@"result"];
        if ([result  isKindOfClass:[NSArray class]])
            
        {
            NSArray *array = (NSArray *)result;
            
            for (int i = 0; i<[array count]; i++)
                
                
            {
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
                obj.jieLike = [innerDic valueForKey:@"LikeCount"];
                obj.jiecomment = [innerDic valueForKey:@"comments"];
                obj.jieUnlike = [innerDic valueForKey:@"unlikeCount"];
                obj.profilePicURL = [innerDic valueForKey:@"profilepic"];

            
                
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
    [req getMyJIE];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 1;
    }
   

    return [_jieArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }
    return 350;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
-(void)didClickOnJIE:(NSString *)userId{
    
}
-(void)didClickOnFriends:(NSString *)userId{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"NewHomeTableViewCell";
        NewHomeTableViewCell *cell = (NewHomeTableViewCell     *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[NewHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (getUser().profilepic.length>0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                
                UIImage *profileimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:getUser().profilepic]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                        cell.imgUserImage.image = profileimage;
                    
                    [cell setNeedsLayout];
                    
                });
            });
        }
       

        return cell;
    }
    
    
    else
    
    {
        
        
        static NSString *CellIdentifier = @"HomeTableViewCell";
    
    HomeTableViewCell *cell = (HomeTableViewCell     *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
        
        JieModel *obj = [_jieArray objectAtIndex:indexPath.row];
        cell.lbluserName.text = obj.username;
        cell.lblTitle.text = obj.title;
        cell.postId = obj.jieId;
        cell.lblDescription.text = obj.jieDescription;
        cell.lblComment.text = obj.jiecomment;
        cell.lblLike.text = obj.jieLike;
        
        
        
    if (obj.profilePicURL.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            UIImage *profileimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.profilePicURL]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(indexPath.row==0){
                    cell.imgProfile.image = nil;
                }else{
                    
                    cell.imgProfile.image = profileimage;
                }
                
                [cell setNeedsLayout];
                
            });
        });
    }
    if (obj.jieImageURL.length>0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:obj.jieImageURL]]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(indexPath.row==0){
                    cell.imgPost.image = nil;
                }else{
                    
                    cell.imgPost.image = image;
                }
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didClickOnComment:(NSString *)userId
{
    CommentsViewController * cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"commentsView"];
    cvc.postId = userId;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cvc];
    cvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:navController animated:YES completion:nil];
}

-(IBAction)openAddJie:(id)sender{
    [self performSegueWithIdentifier:@"AddJie" sender:self];
}


@end
