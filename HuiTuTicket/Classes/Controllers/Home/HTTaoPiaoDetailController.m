//
//  HTTaoPiaoDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoDetailController.h"
#import "TaoPiaoProductDetailHttp.h"
#import "HTTPDetailCell.h"
@interface HTTaoPiaoDetailController ()

@property (strong, nonatomic) TaoPiaoProductDetailHttp *taopiaoDetailHttp;


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
    
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
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
//            weak_self.dataSource = weak_self.taopiaoDetailHttp.resultModel.info;
            [weak_self.tableView reloadData];
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


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentfier";
    HTTPDetailCell *cell = (HTTPDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTPDetailCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}

@end
