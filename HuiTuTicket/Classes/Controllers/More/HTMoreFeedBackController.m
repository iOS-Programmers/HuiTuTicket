//
//  HTMoreFeedBackController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMoreFeedBackController.h"
#import "FeedbackHttp.h"

@interface HTMoreFeedBackController ()

@property (strong, nonatomic) FeedbackHttp *feedbackHttp;

- (IBAction)onCommitBtnClick:(id)sender;

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
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCommitBtnClick:(id)sender
{

        
    self.feedbackHttp.parameter.ftype = @"1";
    self.feedbackHttp.parameter.mobile = @"";
    self.feedbackHttp.parameter.content = @"测试";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMoreFeedBackController *weak_self = self;
    [self.feedbackHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.feedbackHttp.isValid) {
            [self showSuccess];
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
@end
