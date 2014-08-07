//
//  HTMessageViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMessageViewController.h"
#import "HTMessageCell.h"
#import "MessageListHttp.h"

@interface HTMessageViewController ()


@property (strong, nonatomic) MessageListHttp *messageListHttp;

@end

@implementation HTMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _messageListHttp = [[MessageListHttp alloc] init];
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{
    self.dataSource = [NSMutableArray arrayWithArray:@[@"1",@"2",@"1",@"1",@"1"]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.dataSource.count)
        [self loadDataSource];
    
    [self requestData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 80;
    
}

/**
 *  请求数据
 */
- (void)requestData
{
//    self.messageListHttp.parameter.uid = @"1";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMessageViewController *weak_self = self;
    [self.messageListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.messageListHttp.isValid) {
            [weak_self showWithText:@"获取消息列表成功"];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.messageListHttp.erorMessage];
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
    static NSString *cellIdentifier = @"messageCell";

    HTMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTMessageCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
