//
//  HTTicketRegisterController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketRegisterController.h"
#import "HTRegisterSuccessController.h"
#import "HTTicketBindingController.h"

#import "TicketBindHttp.h"

@interface HTTicketRegisterController ()

@property (strong, nonatomic) TicketBindHttp *ticketBindHttp;

@property (weak, nonatomic) IBOutlet UITextField *ticketNumTF;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *IDNumTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;


- (IBAction)onRegisterBtnClick:(id)sender;

- (IBAction)onBindingBtnClick:(id)sender;
@end

@implementation HTTicketRegisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票注册";
        _ticketBindHttp = [[TicketBindHttp alloc] init];
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

/**
 *  请求联票注册接口
 *
 */
- (IBAction)onRegisterBtnClick:(id)sender {
    

//    [self pushViewController:@"HTRegisterSuccessController"];
}

- (IBAction)onBindingBtnClick:(id)sender {
    
    [self pushViewController:@"HTTicketBindingController"];
}
@end
