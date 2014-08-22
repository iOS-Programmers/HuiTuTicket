//
//  HTYuYueViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTYuYueViewController.h"
#import "HTCYOrderViewController.h"

@interface HTYuYueViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lpCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

- (IBAction)onYuYueBtnClick:(id)sender;
@end

@implementation HTYuYueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"预约";
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

- (IBAction)onYuYueBtnClick:(id)sender
{
    if (FBIsEmpty(self.lpCodeTF.text)) {
        [self showWithText:@"请输入联票号码"];
        return;
    }
    else if (FBIsEmpty(self.nameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    [self.view endEditing:YES];
    
    
    HTCYOrderViewController *vc = [[HTCYOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
