//
//  dropDownView.h
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol dropDownDelegate<NSObject>
-(void)didSelectItemOnDropDownList:(NSString *)value;
-(void)setLayoutForView:(CGFloat)height;
@end
@interface dropDownView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(assign, nonatomic) IBOutlet id <dropDownDelegate> delegate;
@property(strong, nonatomic) NSArray *items;
@property(strong, nonatomic) UILabel *lbltitle;
@property(strong, nonatomic) UIButton *btnOption;
@property(strong, nonatomic) UITableView *tblView;
@end
