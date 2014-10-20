//
//  HTLPHomeController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPHomeController.h"
#import "HTLPIntroduceController.h"
#import "HTStoreManager.h"
#import "HomeBannerHttp.h"

#import "HTTicketRegisterController.h"
#import "HTYuYueViewController.h"
#import "HTMyTicketController.h"
#import "HTSaoMiaoLPTicketDetailVC.h"

@interface HTLPHomeController () <ZBarReaderDelegate>

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIView *footView;

@property (strong, nonatomic) HomeBannerHttp *homeBannerHttp;

- (IBAction)onBottomBtnClick:(id)sender;
@end

@implementation HTLPHomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeBannerHttp = [[HomeBannerHttp alloc] init];
        
        self.title = @"景区联票";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView frameSetHeight:[HTFoundationCommon getScreenHeight] - 44];
    
    [self.view addSubview:self.footView];
    [self.footView frameSetY:self.tableView.frame.size.height - 49];
    
    [self loadBanner];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)loadBanner
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTLPHomeController *weak_self = self;
    [self.homeBannerHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.homeBannerHttp.isValid) {
            
            [weak_self updateBannerUI:weak_self.homeBannerHttp.resultModel.dataArray];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.homeBannerHttp.erorMessage];
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

- (void)updateBannerUI:(NSMutableArray *)array
{
    if ([array count] == 0) {
        return;
    }
    
    Banner *bannerInfo = (Banner *)array[0];
    [self.headImage setImageWithURL:[NSURL URLWithString:bannerInfo.image]];
}

- (IBAction)onBottomBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag)
    {
        case 1:
        {
            //联票注册
            HTTicketRegisterController *vc = [[HTTicketRegisterController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            //出游预约
            HTYuYueViewController *vc = [[HTYuYueViewController alloc] initWithNibName:@"HTYuYueViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 3:
        {
            //我的联票
            HTMyTicketController *vc = [[HTMyTicketController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            //扫一扫
            ZBarReaderViewController *reader = [ZBarReaderViewController new];
            reader.readerDelegate = self;
            reader.supportedOrientationsMask = ZBarOrientationMaskAll;
            reader.title = @"扫一扫";
            [self setOverlayPickerView:reader];
            ZBarImageScanner *scanner = reader.scanner;
            
            [scanner setSymbology: ZBAR_I25
                           config: ZBAR_CFG_ENABLE
                               to: 0];
            reader.hidesBottomBarWhenPushed = YES;
            reader.wantsFullScreenLayout = NO;
            reader.showsZBarControls = NO;
            
            [self pushNewViewController:reader];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - DataSource

- (void)loadDataSource
{
    self.dataSource = [[HTStoreManager shareStoreManager] getLPHomeConfigureArray];
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
    
    NSDictionary *moreDictionary = self.dataSource[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:[moreDictionary valueForKey:@"image"][indexPath.row]];
    cell.textLabel.text = [moreDictionary valueForKey:@"title"][indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger row = indexPath.row;
    
    HTLPIntroduceController *inroduce = [[HTLPIntroduceController alloc] init];
    inroduce.type = [NSString stringWithFormat:@"%d",row+1];
    [self.navigationController pushViewController:inroduce animated:YES];
    
}

#pragma mark - ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
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
