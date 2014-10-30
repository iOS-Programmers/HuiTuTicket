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

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lable;
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *image = [UIImage imageNamed:@"more_feedback@2x.png"];
    CGFloat top = 20; // 顶端盖高度
    CGFloat bottom = 20 ; // 底端盖高度
    CGFloat left = 28; // 左端盖宽度
    CGFloat right = 15; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, 96, 88);
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:(CGRect){{0,imageView.frame.origin.y + imageView.frame.size.height +5 },{320,20}}];
    lable.text = @"暂时没有新消息";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    lable.hidden = YES;
    [self.view addSubview:lable];
    self.lable = lable;
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configuraTableViewNormalSeparatorInset];
}

/**
 *  请求数据
 */
- (void)requestData
{
    //未登录的情况返回
//    if ([[[HTUserInfoManager shareInfoManager] sessionKey] length] < 1) {
//
//        return;
//    }
    self.messageListHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.messageListHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMessageViewController *weak_self = self;
    [self.messageListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.messageListHttp.isValid) {
            [weak_self updateUIWithMessageData:weak_self.messageListHttp.resultModel];
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


- (void)updateUIWithMessageData:(MessageList *)list
{
    //刷新界面
    
    self.dataSource = list.info;
    //self.dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    if (!self.dataSource.count>0) {
        self.imageView.hidden = NO;
        self.lable.hidden = NO;
    }else
    {
        self.imageView.hidden = YES;
        self.lable.hidden = YES;
    }
    [self.tableView reloadData];
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"messageCell";

    HTMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTMessageCell" owner:self options:nil] lastObject];
    }
    [cell configureUIWithData:(MessageDetail *)self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
