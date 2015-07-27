//
//  HomeTableViewCell.m
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "CommentsViewController.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickComment:(id)sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didClickOnComment:)]) {
        [_delegate didClickOnComment:_postId];
    }
}
@end
