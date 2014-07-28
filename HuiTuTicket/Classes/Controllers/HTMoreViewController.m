//
//  HTMoreViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMoreViewController.h"
#import "HTStoreManager.h"

//#import "ZBarSDK.h"
#import "HTMoreAboutUsController.h"


@interface HTMoreViewController ()

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
            //扫一扫
//            ZBarReaderViewController *reader = [ZBarReaderViewController new];
//            reader.readerDelegate = self;
//            reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//            
//            ZBarImageScanner *scanner = reader.scanner;
//            
//            [scanner setSymbology: ZBAR_I25
//                           config: ZBAR_CFG_ENABLE
//                               to: 0];
//            
//            [self presentViewController:reader animated:YES completion:^{
//                
//            }];
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


@end
