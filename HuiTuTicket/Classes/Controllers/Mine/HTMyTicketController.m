//
//  HTMyTicketController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMyTicketController.h"
#import "HTMyTicketCell.h"
#import "MyTicketHttp.h"
#import "HTTicketDetailController.h"

#import "HTTicketRegisterController.h"

@interface HTMyTicketController ()

@property (strong, nonatomic) MyTicketHttp *myticketHttp;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lable;

@end

@implementation HTMyTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的联票";
        _myticketHttp = [[MyTicketHttp alloc] init];
    }
    return self;
}
//确定按钮
- (void)configuraAddTicketButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(ticketRegister)];
}
- (void)ticketRegister
{
    HTTicketRegisterController *ticketVC = [[HTTicketRegisterController alloc] init];
    [self.navigationController pushViewController:ticketVC animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configuraAddTicketButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lphome_03_big@2x"]];
    imageView.bounds = CGRectMake(0, 0, 96, 88);
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:(CGRect){{0,imageView.frame.origin.y + imageView.frame.size.height +5 },{320,20}}];
    lable.text = @"暂时无联票，快来注册吧";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    lable.hidden = YES;
    [self.view addSubview:lable];
    self.lable = lable;

    
    self.tableView.rowHeight = 110;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)requestData
{
    
    self.myticketHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.myticketHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.myticketHttp.parameter.page = @"1";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMyTicketController *weak_self = self;
    [self.myticketHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.myticketHttp.isValid) {
            weak_self.dataSource = weak_self.myticketHttp.resultModel.info;

            if ([weak_self.dataSource count] == 0) {
                self.imageView.hidden = NO;
                self.lable.hidden = NO;
            }else
            {
                self.imageView.hidden = YES;
                self.lable.hidden = YES;
            }
            
            
            [weak_self.tableView reloadData];

        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.myticketHttp.erorMessage];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myticketCell";
    
    HTMyTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTMyTicketCell" owner:self options:nil] lastObject];
    }
    
    [cell configureWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    HTTicketDetailController *vc = [[HTTicketDetailController alloc] init];
    MyTicket *ticker = (MyTicket *)self.dataSource[indexPath.row];
    vc.ticket = ticker;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
