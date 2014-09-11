//
//  HTMineViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMineViewController.h"
#import "HTStoreManager.h"

#import "HTMyTicketController.h"
#import "HTLoginController.h"

@interface HTMineViewController ()
{

}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginAlertLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)onLogin:(id)sender;

@end

@implementation HTMineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{
    self.dataSource = [[HTStoreManager shareStoreManager] getMineConfigureArray];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:UPDATE_USERINFO object:nil];

    
    self.tableView.tableHeaderView = self.headerView;
    
    
    [self updateUI];


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action

/**
 *  更新用户信息界面
 */
- (void)updateUI
{
    //用户未登录时候
    if ([[[HTUserInfoManager shareInfoManager] sessionKey] length] < 1) {
        self.loginAlertLabel.text = @"您还没有登录哦";
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        self.loginAlertLabel.hidden = NO;
        self.userNameLabel.hidden = YES;
        self.avatarImage.hidden = YES;

    }
    else {
        [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
        self.loginAlertLabel.text = @"亲，您已经成功登录！";

        self.userNameLabel.hidden = NO;
        self.avatarImage.hidden = NO;
        
        GetUserInfo *info = [[HTUserInfoManager shareInfoManager] userInfo];
        
        self.userNameLabel.text = info.nickname;
        [self.avatarImage setImageWithURL:[NSURL URLWithString:info.headpic] placeholderImage:[UIImage imageNamed:@"my_avatar_default"]];
    }
    
}


- (IBAction)onLogin:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"退出登录"]) {
        //退出登录操作
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
        
    }
    else {
        HTLoginController *loginVC = [[HTLoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        [self.navigationController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //退出登录
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SESSION_KEY];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USERINFO object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        //        self.logoutHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
        //        self.logoutHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
        //
        //
        //        [self showLoadingWithText:kLOADING_TEXT];
        //        __block HTUserInfoController *weak_self = self;
        //        [self.logoutHttp getDataWithCompletionBlock:^{
        //            [weak_self hideLoading];
        //
        //            if (weak_self.logoutHttp.isValid) {
        //
        //                /**
        //                 *  退出登录成功后 移除掉sessionKey userid 返回到上个页面
        //                 */
        //                [[NSUserDefaults standardUserDefaults] removeObjectForKey:SESSION_KEY];
        //                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
        //
        //                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USERINFO object:nil];
        //
        //                [self.navigationController popViewControllerAnimated:YES];
        //
        //
        //            }
        //            else {
        //                //显示服务端返回的错误提示
        //                [weak_self showErrorWithText:weak_self.logoutHttp.erorMessage];
        //            };
        //
        //
        //        }failedBlock:^{
        //            [weak_self hideLoading];
        //            if (![HTFoundationCommon networkDetect]) {
        //
        //                [weak_self showErrorWithText:kNETWORK_ERROR];
        //            }
        //            else {
        //                
        //                //统统归纳为服务器出错
        //                [weak_self showErrorWithText:kSERVICE_ERROR];
        //            };
        //        }];
        
    }
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < self.dataSource.count) {
        NSDictionary *moreDictionary = self.dataSource[indexPath.section];
        cell.imageView.image = [UIImage imageNamed:[moreDictionary valueForKey:@"image"][indexPath.row]];
        cell.textLabel.text = [moreDictionary valueForKey:@"title"][indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;

    //用户未登录 弹出登录页面
    if ([[[HTUserInfoManager shareInfoManager] sessionKey] length] < 1) {
        
        [self onLogin:self.loginButton];
        return;
    }
    
    
    NSInteger section = indexPath.section;
    switch (section) {
       case 0: {
            HTMyTicketController *myTicket = [[HTMyTicketController alloc] init];
            myTicket.hidesBottomBarWhenPushed = YES;
            viewController = myTicket;
            break;
        }
        
            
        default: {
            //只有我的联票可用，其他的点击提示该功能暂未开发，尽请期待。
            [self showWithText:@"该功能暂未开发，尽请期待！"];
        }
            break;
    }
    if (viewController) {
        [self pushNewViewController:viewController];
    }

}

#pragma mark - Action
@end
