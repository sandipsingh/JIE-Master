//
//  notificationTableViewCell.h
//  JiE
//
//  Created by Rajesh on 12/08/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol notificationDelegate<NSObject>
-(void)didSelectItemAtIndex:(NSInteger )row;
@end
@interface notificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblcomment;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet id <notificationDelegate> delegate;
@property (assign, nonatomic) NSInteger rowIndex;
- (IBAction)deleteCliecked:(id)sender;
@end
