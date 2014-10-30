//
//  HTMoreFeedBackController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMoreFeedBackController.h"
#import "PlacehoderTextView.h"
#import "FeedbackHttp.h"

@interface HTMoreFeedBackController ()<UITextViewDelegate>
{
    PlacehoderTextView *_textView;
}

@property (strong, nonatomic) FeedbackHttp *feedbackHttp;
@property (weak, nonatomic) IBOutlet UIButton *jianyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *tousuBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)onCommitBtnClick:(id)sender;

- (IBAction)onFeedTypeBtnClick:(id)sender;
@end

@implementation HTMoreFeedBackController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"意见反馈";
        _feedbackHttp = [[FeedbackHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.jianyiBtn.selected = YES;
    
    _textView = [[PlacehoderTextView alloc] initWithFrame:CGRectMake(10, 10, 300, 90)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.placeholder = @"我们向您承诺，您在惠游河南的每一次体验都应当是完美的。如果能达到您的期望，请告诉我们，我们愿意付出努力来信守承诺。";
    
    [self.contentView addSubview:_textView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)onCommitBtnClick:(id)sender
{
    if (FBIsEmpty(self.phoneNumberTF.text)) {
        [self showErrorWithText:@"请输入手机号"];
        
        return;
    }
    else if (FBIsEmpty(_textView.text)) {
        [self showErrorWithText:@"请输入反馈内容"];
        
        return;
    }
    
    [self.view endEditing:YES];
        
    self.feedbackHttp.parameter.ftype = self.jianyiBtn.selected ? @"1" : @"2";
    self.feedbackHttp.parameter.mobile = self.phoneNumberTF.text;
    self.feedbackHttp.parameter.content = _textView.text;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMoreFeedBackController *weak_self = self;
    [self.feedbackHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.feedbackHttp.isValid) {
            
            [self showWithText:@"提交成功，感谢您的反馈！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.feedbackHttp.erorMessage];
        };
        
        
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {
            
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else {
            
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
    

}

- (IBAction)onFeedTypeBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.jianyiBtn.selected = NO;
    self.tousuBtn.selected = NO;
    
    btn.selected = !btn.selected;
}

#pragma mark - UITextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
