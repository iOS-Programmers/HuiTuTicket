//
//  HTTaoPiaoTicketController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoTicketController.h"

#import "HTTaopiaoListCell.h"

#import "HTTaoPiaoDetailController.h"

#import "TaoPiaoProductListHttp.h"

#import "TaoPiaoProduct.h"

@interface HTTaoPiaoTicketController ()

@property (strong, nonatomic) TaoPiaoProductListHttp *taopiaoListHttp;

@end

@implementation HTTaoPiaoTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区套票";
        
        _taopiaoListHttp = [[TaoPiaoProductListHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 80;
    
    [self loadDataSource];
}

- (void)loadDataSource
{

    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaoPiaoTicketController *weak_self = self;
    [self.taopiaoListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.taopiaoListHttp.isValid) {
            weak_self.dataSource = weak_self.taopiaoListHttp.resultModel.info;
            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.taopiaoListHttp.erorMessage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTTaopiaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoListCell" owner:self options:nil] lastObject];
    }
    
    TaoPiaoProduct *info = (TaoPiaoProduct *)self.dataSource[indexPath.row];
    
    [cell.imgView setImageWithURL:[NSURL URLWithString:info.picture]];
    cell.ticketName.text = info.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",info.minprice];

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TaoPiaoProduct *info = (TaoPiaoProduct *)self.dataSource[indexPath.row];

    HTTaoPiaoDetailController *app = [[HTTaoPiaoDetailController alloc] init];
    app.hidesBottomBarWhenPushed = YES;
    app.productInfo = info;
    [self.navigationController pushViewController:app animated:YES];
}


@end
