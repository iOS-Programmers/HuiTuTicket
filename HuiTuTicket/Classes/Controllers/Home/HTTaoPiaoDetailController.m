//
//  HTTaoPiaoDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoDetailController.h"
#import "TaoPiaoProductDetailHttp.h"
<<<<<<< HEAD
#import "HTTaopiaoDetailCell.h"
#import "TaoPiaoScenicInfo.h"
#import "TaoPiaoTicket.h"

=======
#import "HTTPDetailCell.h"
>>>>>>> FETCH_HEAD
@interface HTTaoPiaoDetailController ()

@property (strong, nonatomic) TaoPiaoProductDetailHttp *taopiaoDetailHttp;

@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
@property (weak, nonatomic) IBOutlet UITextView *shuomingTextView;

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIImageView *scenicImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (IBAction)onOrderBtnClick:(id)sender;
@end

@implementation HTTaoPiaoDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"套票详情";
        
        _taopiaoDetailHttp = [[TaoPiaoProductDetailHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 60;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.tableFooterView;
    [self.tableView frameSetHeight:[HTFoundationCommon getScreenHeight] + (IOS7_OR_LATER ? 20 : 0) - 50];

    [self.view addSubview:self.footView];
    [self.footView frameSetY:self.tableView.frame.size.height];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onOrderBtnClick:(id)sender {
}


- (void)loadDataSource
{
    self.taopiaoDetailHttp.parameter.tpid = self.productInfo.tpid;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaoPiaoDetailController *weak_self = self;
    [self.taopiaoDetailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.taopiaoDetailHttp.isValid) {

            [weak_self updateUIWithInfo:weak_self.taopiaoDetailHttp.resultModel];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.taopiaoDetailHttp.erorMessage];
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


- (void)updateUIWithInfo:(TaoPiaoProductDetail *)detailInfo
{
    [self.scenicImage setImageWithURL:[NSURL URLWithString:detailInfo.picture]];
    self.productNameLabel.text = detailInfo.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",detailInfo.price];
    
//    self.shuomingTextView.text = [NSString stringWithFormat:@"%@\n%@",detailInfo.content,detailInfo.ydsm];
    self.shuomingTextView.text = [NSString stringWithFormat:@"%@",detailInfo.ydsm];
    
    if ([detailInfo.scenicinfo count] != 0) {
        self.dataSource = detailInfo.scenicinfo;
        [self.tableView reloadData];
    }
    
    
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
<<<<<<< HEAD
    HTTaopiaoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoDetailCell" owner:self options:nil] lastObject];
    }
    TaoPiaoScenicInfo *info = (TaoPiaoScenicInfo *)self.dataSource[indexPath.row];
    if ([info.ticket count] > 0) {
        TaoPiaoTicket *ticket = (TaoPiaoTicket *)info.ticket[0];
        cell.ticketAndNumLabel.text = [NSString stringWithFormat:@"%@    %@张",ticket.ticketName,ticket.num];
        cell.priceLabel.text = [NSString stringWithFormat:@"价值    ￥%@",ticket.price];
=======
    HTTPDetailCell *cell = (HTTPDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTPDetailCell" owner:self options:nil] lastObject];
>>>>>>> FETCH_HEAD
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
<<<<<<< HEAD
    cell.scenicName.text = info.scenicName;
    
=======
>>>>>>> FETCH_HEAD
    return cell;
}

@end
