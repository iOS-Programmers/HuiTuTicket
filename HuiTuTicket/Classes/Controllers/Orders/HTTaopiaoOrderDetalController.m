//
//  HTTaopiaoOrderDetalController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaopiaoOrderDetalController.h"

@interface HTTaopiaoOrderDetalController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *caseCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiangjinLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yudingNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *scenicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *traveltimeLabel;

- (IBAction)onCancelOrderBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onPayBtnClick;

@end

@implementation HTTaopiaoOrderDetalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(320, 400)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelOrderBtnClick:(id)sender {
}
@end
