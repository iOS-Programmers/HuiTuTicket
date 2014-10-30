//
//  HTMoreViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMoreViewController.h"
#import "HTStoreManager.h"

#import "ZBarSDK.h"
#import "HTSaoMiaoLPTicketDetailVC.h"

#import "HTMoreAboutUsController.h"
#import "HTMoreFeedBackController.h"
#import "HTMoreHelpController.h"
#import "CheckUpdate.h"


@interface HTMoreViewController ()<ZBarReaderDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) ZBarReaderViewController *readerVC;

@end

@implementation HTMoreViewController

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
    self.dataSource = [[HTStoreManager shareStoreManager] getMoreConfigureArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0: {
            //设置

        }
            break;
        case 1: {

            switch (row) {
                case 0: {
                    //扫一扫
                    self.readerVC = [ZBarReaderViewController new];
                    self.readerVC.readerDelegate = self;
                    self.readerVC.supportedOrientationsMask = ZBarOrientationMaskAll;
                    self.readerVC.wantsFullScreenLayout = NO;
                    self.readerVC.showsZBarControls = NO;
                    [self setOverlayPickerView:self.readerVC];
                    ZBarImageScanner *scanner = self.readerVC.scanner;
                    
                    [scanner setSymbology: ZBAR_I25
                                   config: ZBAR_CFG_ENABLE
                                       to: 0];
                    self.readerVC.hidesBottomBarWhenPushed = YES;
                    self.readerVC.showsZBarControls = NO;

                    
                    viewController = self.readerVC;
                }
                    break;
                    
                case 1: {
                    //意见反馈
                    HTMoreFeedBackController *feedback = [[HTMoreFeedBackController alloc] init];
                    feedback.hidesBottomBarWhenPushed = YES;
                    viewController = feedback;
                
                }
                    break;
                case 2: {
                    //帮助中心
                    HTMoreHelpController *help = [[HTMoreHelpController alloc] init];
                    help.hidesBottomBarWhenPushed = YES;
                    viewController = help;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2: {
            //给我评分
            NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", APP_ID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            break;
        case 3: {
            switch (row) {
                case 0: {
                    //检查更新
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self checkVersionUpdate];
                    });
                
                }
                    break;
                case 1: {
                    //关于我们
                    HTMoreAboutUsController *aboutUs = [[HTMoreAboutUsController alloc] init];
                    aboutUs.hidesBottomBarWhenPushed = YES;
                    viewController = aboutUs;
                }
                    break;
                    
                default:
                    break;
            }
        }
            
        default:
            break;
    }
    
    if (viewController) {
        [self pushNewViewController:viewController];
    }
   
}

/**
 *  检查版本更新
 */
- (void)checkVersionUpdate
{
    BOOL haveUpdate = [[CheckUpdate shareInstance] checkUp];
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        if (haveUpdate) {
            UIAlertView  *updateAlert = [[UIAlertView alloc] initWithTitle:@"更新提醒" message: @"有新版本了！" delegate:self cancelButtonTitle:@"立刻升级" otherButtonTitles: @"稍后提醒", nil];
            
            [updateAlert show];
            
        }
        else {
            [self showWithText:@"当前是最新版本!"];
            
        }
    });
    
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSString *iTunesLink = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?ls=1&mt=8",APP_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
}

#pragma mark - ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //得到扫码的结果
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //扫描到联票号码，进入联票详情资料页
        HTSaoMiaoLPTicketDetailVC *saomiao = [[HTSaoMiaoLPTicketDetailVC alloc] init];
        saomiao.ticketNumber = symbol.data;
        [self.navigationController pushViewController:saomiao animated:NO];
    });
}




@end
