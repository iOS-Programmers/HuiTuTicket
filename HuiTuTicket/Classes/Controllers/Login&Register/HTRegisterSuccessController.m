//
//  HTRegisterSuccessController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTRegisterSuccessController.h"
#import "HTMyTicketController.h"

@interface HTRegisterSuccessController ()

- (IBAction)onMyTicketBtnClick:(id)sender;

- (IBAction)onRegisterBtnClick:(id)sender;
@end

@implementation HTRegisterSuccessController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册成功";
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

- (IBAction)onMyTicketBtnClick:(id)sender
{
    [self pushViewController:@"HTMyTicketController"];
}

- (IBAction)onRegisterBtnClick:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
