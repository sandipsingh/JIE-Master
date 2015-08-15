///




#import "MyJiePageCellsController.h"
#import "CommentsViewController.h"
@implementation MyJiePageCellsController

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
