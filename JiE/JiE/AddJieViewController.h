//
//  AddJieViewController.h
//  JiE
//
//  Created by Rajesh on 14/07/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "Request.h"
#import "JieClass.h"
#import "dropDownView.h"
@interface AddJieViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnImagePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnVideoPicker;
@property (weak, nonatomic) IBOutlet UIButton *btnTick;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeCalculator;
@property (weak, nonatomic) IBOutlet UIButton *btnMoneyCalculator;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
@property (weak, nonatomic) IBOutlet UIScrollView *jieScrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtInvite;
@property (weak, nonatomic) IBOutlet UIView *mCalculatorView;
@property (weak, nonatomic) IBOutlet UIView *mContentView;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UITextField *txtMinutes;
@property (weak, nonatomic) IBOutlet UITextField *txtHours;
@property (weak, nonatomic) IBOutlet UITextField *txtDays;
@property (weak, nonatomic) IBOutlet UITextField *txtWeeks;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeValue;
@property (weak, nonatomic) IBOutlet UITextField *txtCost;
@property (weak, nonatomic) IBOutlet UITextField *txtSalary;
@property (weak, nonatomic) IBOutlet UILabel *lblSalary;
@property (weak, nonatomic) IBOutlet dropDownView *privacyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceForScrollView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSData *videoData;
@property (strong, nonatomic) NSString *strPrivacy;
@property (assign, nonatomic) BOOL isImage;
@property (assign, nonatomic) BOOL isMoneySelected;
@property (strong, nonatomic) UIImage *thumbImage;
- (IBAction)openImagePicker:(id)sender;
- (IBAction)openVideoPicker:(id)sender;
- (IBAction)openTick:(id)sender;
- (IBAction)openMoneyCalculator:(id)sender;
- (IBAction)openTimeCalculator:(id)sender;
- (IBAction)openPost:(id)sender;
@end
