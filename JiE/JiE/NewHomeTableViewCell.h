//
//  sampleTableViewCell.h
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewHomeTableViewCellDelegate<NSObject>
-(void)didClickOnComment:(NSString *)userId;
-(void)didClickOnJIE:(NSString *)userId;
-(void)didClickOnFriends:(NSString *)userId;
@end

@interface NewHomeTableViewCell : UITableViewCell
@property (assign, nonatomic) IBOutlet id <NewHomeTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lbluserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackgroundImage;

@property (weak, nonatomic) IBOutlet UIButton *btnJie;
@property (weak, nonatomic) IBOutlet UIButton *btnFriends;
@property (strong, nonatomic) IBOutlet UILabel *lblLike;
- (IBAction)onClickComment:(id)sender;
- (IBAction)onClickFrinds:(id)sender;
- (IBAction)onClickJIE:(id)sender;




//@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
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


@end
