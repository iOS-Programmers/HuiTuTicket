//
//  HTLoginController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-23.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLoginController.h"
#import "HTLoginTextField.h"    
#import "HTRegeisterController.h"
@interface HTLoginController ()

@property (weak, nonatomic) IBOutlet HTLoginTextField *userNameTF;
@property (weak, nonatomic) IBOutlet HTLoginTextField *passwordTF;

- (IBAction)onLoginBtnClick:(id)sender;
- (IBAction)onFindPasswordClick:(id)sender;
- (IBAction)onRegisterBtnClick:(id)sender;

@end

@implementation HTLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"登录";
    }
    return self;
}

- (void)configuraBackButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configuraBackButton];
    
    self.view.backgroundColor = UIColorRGB(235, 235, 235);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)onLoginBtnClick:(id)sender {
}

- (IBAction)onFindPasswordClick:(id)sender {
}

- (IBAction)onRegisterBtnClick:(id)sender
{
    [self pushViewController:@"HTRegeisterController"];
}
@end
