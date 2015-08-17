//
//  sampleTableViewCell.h
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeTableViewCellDelegate<NSObject>

-(void)didClickOnComment:(NSString *)postId;
-(void)didClickOnVideo:(NSInteger )rowIndex;
@end

@interface HomeTableViewCell : UITableViewCell
@property (assign, nonatomic) IBOutlet id <HomeTableViewCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UILabel *lbluserName;
@property (strong, nonatomic) IBOutlet UILabel *lblLastSeen;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgPost;
@property (strong, nonatomic) IBOutlet UIButton *btnComment;
@property (strong, nonatomic) IBOutlet UILabel *lblComment;
@property (strong, nonatomic) NSString *postId;
@property (assign, nonatomic) NSInteger rowIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnVideo;
- (IBAction)videoClicked:(id)sender;

- (IBAction)onClickComment:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblLike;
@end
