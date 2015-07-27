//
//  commentsTableViewCell.h
//  JiE
//
//  Created by Rajesh on 27/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
