//
//  HTOrderResultViewController.m
//  HuiTuTicket
//
//  Created by on 14-8-8.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderResultViewController.h"
#import "HTHomeTableViewCell.h"

@interface HTOrderResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;

- (IBAction)onClientPayBtnClick:(UIButton *)sender;
- (IBAction)onWebPayBtnClick:(UIButton *)sender;

@end

@implementation HTOrderResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"支付方式";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self refreshUIShow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (void)refreshUIShow
{

}


#pragma mark - Action
/**
 *  支付宝客户端支付
 *
 */
- (IBAction)onClientPayBtnClick:(UIButton *)sender
{


}

/**
 *  支付宝网页支付
 *
 */
- (IBAction)onWebPayBtnClick:(UIButton *)sender
{

    [self showWithText:@"该功能暂未开发！"];
}
@end
