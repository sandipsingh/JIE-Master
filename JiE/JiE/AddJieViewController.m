//
//  AddJieViewController.m
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import "AddJieViewController.h"

@interface AddJieViewController ()

@end

@implementation AddJieViewController

-(void)getResult:(id)response{
    NSLog(@" getResult ");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Jie";
    [_privacyView setItems:@[@"Only me",@"Friends",@"Public"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}
-(void)keyboardWillHide:(NSNotification *)notification{
    _bottomSpaceForScrollView.constant = 0;
}
-(void)keyboardDidShow:(NSNotification *)notification{
    NSDictionary * info = [notification userInfo];
    CGRect beginFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    _bottomSpaceForScrollView.constant = beginFrame.size.height;
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
-(void)didSelectItemOnDropDownList:(NSString *)value{
    _strPrivacy = value;
}
-(void)showImagePickerWithSourceType:(NSInteger)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    switch (sourceType) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [picker setShowsCameraControls:YES];
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            break;
    }
    
    if (!_isImage) {
        picker.mediaTypes = [NSArray arrayWithObject:@"public.movie"];;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        [picker setVideoMaximumDuration:120];
    }
    [self presentViewController:picker animated:YES completion:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.jieScrollView setContentOffset:CGPointMake(0, self.mContentView.frame.origin.y)];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:@"Image"]) {
        _isImage = YES;
    }
    else{
        _isImage = NO;
    }
    switch (buttonIndex) {
        case 0:
            [self showImagePickerWithSourceType:buttonIndex];
            break;
        case 1:
            [self showImagePickerWithSourceType:buttonIndex];
            break;
        default:
            break;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _txtMinutes) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+165)];
    }
    else  if (textField == _txtHours) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+190)];
    }
    else  if (textField == _txtDays) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+215)];
    }
    else  if (textField == _txtWeeks) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+245)];
    }
    else  if (textField == _txtSalary) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+210)];
    }
    else  if (textField == _txtCost) {
        [_jieScrollView setContentOffset:CGPointMake(0, _jieScrollView.frame.origin.y+165)];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_isMoneySelected == YES && textField == _txtSalary && _txtCost.text.length>0) {
        _lblSalary.text = [NSString stringWithFormat:@"%f%% of Salary.",([_txtSalary.text floatValue]/[_txtCost.text floatValue])*100];
    }
    else if(_isMoneySelected == NO ){
        if (textField == _txtMinutes && _txtHours.text.length == 0 && _txtDays.text.length == 0 && _txtWeeks.text.length == 0) {
            _lblTimeValue.text = [NSString stringWithFormat:@"%f%% of my hour.",([_txtMinutes.text floatValue]/60)*100];
        }
        else if(textField == _txtHours && _txtMinutes.text.length > 0 && _txtDays.text.length == 0 && _txtWeeks.text.length == 0){
            _lblTimeValue.text = [NSString stringWithFormat:@"%f%% of my day.",((([_txtHours.text floatValue]*60)+[_txtMinutes.text floatValue])/1440)*100];
        }
        else if(textField == _txtDays && _txtMinutes.text.length > 0 && _txtHours.text.length > 0 && _txtWeeks.text.length == 0){
            _lblTimeValue.text = [NSString stringWithFormat:@"%f%% of my week.",((([_txtDays.text floatValue]*1440)+(([_txtHours.text floatValue]*60)+[_txtMinutes.text floatValue]))/10080)*100];
        }
        else if(textField == _txtWeeks && _txtMinutes.text.length > 0 && _txtHours.text.length > 0 && _txtDays.text.length > 0){
            _lblTimeValue.text = [NSString stringWithFormat:@"%f%% of my year.",((([_txtWeeks.text floatValue]*10080)+(([_txtDays.text floatValue]*1440)+(([_txtHours.text floatValue]*60)+[_txtMinutes.text floatValue])))/525960)*100];
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_isImage) {
        self.image = nil;
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    else{
        self.videoData = nil;
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self.videoData = [NSData dataWithContentsOfURL:videoURL];
        
        AVAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
        _thumbImage = nil;
        
        if ([[avAsset tracksWithMediaType:AVMediaTypeVideo] count] > 0)
        {
            AVAssetImageGenerator *imageGenerator =[AVAssetImageGenerator assetImageGeneratorWithAsset:avAsset];
            NSError *error;
            CMTime actualTime;
            CGImageRef halfWayImage = [imageGenerator copyCGImageAtTime:kCMTimeZero actualTime:&actualTime error:&error];
            if (halfWayImage != NULL)
            {
                _thumbImage=[UIImage imageWithCGImage:halfWayImage];
            }
        }
    }
}
- (IBAction)openImagePicker:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Gallery", nil];
    [sheet showInView:self.view];
}

- (IBAction)openVideoPicker:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Video" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Gallery", nil];
    [sheet showInView:self.view];
}

- (IBAction)openTick:(id)sender {
}

- (IBAction)openMoneyCalculator:(id)sender {
    _isMoneySelected = YES;
    _mCalculatorView.hidden = NO;
    _timeView.hidden = YES;
}

- (IBAction)openTimeCalculator:(id)sender {
    _isMoneySelected = NO;
    _mCalculatorView.hidden = YES;
    _timeView.hidden = NO;
}

- (IBAction)openPost:(id)sender {
    
    Request *reqObj = [[Request alloc] init];
    reqObj.delegate = self;

    JieClass *obj = [[JieClass alloc] init];
    obj.userid = @"93";
    obj.userEmail = @"rpatel9630@yahoo.com";
    obj.username = @"rajesh";
    obj.title = _txtTitle.text;
    obj.des = _txtDescription.text;
    if (_image != nil) {
        obj.image = UIImagePNGRepresentation(_image);
    }
    if (_videoData.length>0) {
        obj.video = _videoData;
    }
    obj.privacy = _strPrivacy;
    
    if (_isMoneySelected == YES) {
        if (_lblSalary.text.length>0) {
            obj.salary = [_txtSalary.text floatValue];
        }
        if (_txtCost.text.length>0) {
            obj.cost = [_txtCost.text floatValue];
        }
        obj.result = _lblSalary.text;
    }
    else{
        if (_lblTimeValue.text.length>0) {
            obj.result = _lblTimeValue.text;
        }
    }
    if (_thumbImage != nil) {
        obj.profilepic = UIImagePNGRepresentation(_thumbImage);
    }
    Request *rObj = [[Request alloc] init];
    rObj.delegate = self;
    [rObj addJieWithParameter:obj];
    
}
-(void)dealloc{
    self.thumbImage = nil;
    self.image = nil;
    self.videoData = nil;
    self.strPrivacy = nil;
}
@end
