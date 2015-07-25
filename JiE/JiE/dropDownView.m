//
//  dropDownView.m
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "dropDownView.h"

@implementation dropDownView
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        _lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bounds.size.width-5, self.bounds.size.height)];
        _lbltitle.textAlignment = NSTextAlignmentLeft;
        
        _lbltitle.textColor = [UIColor blackColor];
        _lbltitle.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_lbltitle];
        _btnOption = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [_btnOption addTarget:self action:@selector(openTable:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnOption];
        
        _tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnOption.frame), self.bounds.size.width, 0)];
        _tblView.delegate = self;
        _tblView.dataSource = self;
        _tblView.scrollEnabled = YES;
        [self addSubview:_tblView];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3f;
    }
    return self;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    _lbltitle.text = @"Privacy";
    [_tblView reloadData];
}
-(IBAction)openTable:(id)sender{
    _btnOption.selected = !_btnOption.selected;
    CGRect viewFrame = self.frame;
    if (_btnOption.selected) {
        viewFrame.size.height = self.bounds.size.height+100;
        self.frame = viewFrame;
        _tblView.frame = CGRectMake(0, CGRectGetMaxY(_btnOption.frame), self.bounds.size.width, 100);
    }
    else{
        viewFrame.size.height = self.bounds.size.height-100;
        self.frame = viewFrame;
        _tblView.frame = CGRectMake(0, CGRectGetMaxY(_btnOption.frame), self.bounds.size.width, 0);
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(setLayoutForView:)]) {
        [_delegate setLayoutForView:self.bounds.size.height];
    }
}
#pragma -mark TableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"dropDownCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma -mark TableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _lbltitle.text = [_items objectAtIndex:indexPath.row];
    [self openTable:nil];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectItemOnDropDownList:)]) {
        [_delegate didSelectItemOnDropDownList:_lbltitle.text];
    }
}
@end
