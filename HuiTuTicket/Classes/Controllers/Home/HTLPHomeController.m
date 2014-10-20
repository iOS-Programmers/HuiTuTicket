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


@interface HTLPHomeController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (strong, nonatomic) HomeBannerHttp *homeBannerHttp;

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
    NSInteger section = indexPath.section;
    
    HTLPIntroduceController *inroduce = [[HTLPIntroduceController alloc] init];
    inroduce.type = [NSString stringWithFormat:@"%d",row+1];
    [self.navigationController pushViewController:inroduce animated:YES];
    
}

@end
