//
//  HTTaoPiaoYuDingController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoYuDingController.h"

#import "TPOrderSubmitHttp.h"

#import "HTTaopiaoYuDingCell.h"

#import "TaoPiaoScenicInfo.h"

#import "TaoPiaoTicket.h"

@interface HTTaoPiaoYuDingController ()

@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UIView *tableFootView;

@property (weak, nonatomic) IBOutlet UILabel *totoalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UILabel *ticketName;

@property (weak, nonatomic) IBOutlet UILabel *ticketNumLabel;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


@property (strong, nonatomic) TPOrderSubmitHttp *submitHttp;

- (IBAction)onPayBtnClick:(id)sender;
- (IBAction)onPlusAction:(UIButton *)sender;
- (IBAction)onMinAction:(UIButton *)sender;



@end

@implementation HTTaoPiaoYuDingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"填写订单";
        _submitHttp = [[TPOrderSubmitHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 88;
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFootView;
    
    [self.tableView frameSetHeight:[HTFoundationCommon getScreenHeight] + (IOS7_OR_LATER ? 20 : 0) - 44];
    
    
    [self updateUIWithInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action

- (void)updateUIWithInfo
{
    if (self.productInfo) {
        self.ticketName.text = self.productInfo.title;
        
        if ([self.productInfo.scenicinfo count] > 0) {
            self.dataSource = self.productInfo.scenicinfo;
            [self.tableView reloadData];
        }
        
    }
}

- (IBAction)onPayBtnClick:(id)sender {
}

- (IBAction)onPlusAction:(UIButton *)sender {
}

- (IBAction)onMinAction:(UIButton *)sender {
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentfier";
    
    HTTaopiaoYuDingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoYuDingCell" owner:self options:nil] lastObject];
    }
    
    TaoPiaoScenicInfo *info = (TaoPiaoScenicInfo *)self.dataSource[indexPath.row];
    if ([info.ticket count] > 0) {
        TaoPiaoTicket *ticket = (TaoPiaoTicket *)info.ticket[0];
        cell.ticketNumLabel.text = [NSString stringWithFormat:@"%@张",ticket.num];
        cell.ticketTypeLabel.text = [NSString stringWithFormat:@"%@",ticket.ticketName];
    }
    
    cell.scenicName.text = info.scenicName;
    
    
    return cell;
}
@end
