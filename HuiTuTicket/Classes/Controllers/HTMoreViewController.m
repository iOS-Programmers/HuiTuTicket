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

#import "HTMoreAboutUsController.h"
#import "HTMoreFeedBackController.h"
#import "HTMoreHelpController.h"


@interface HTMoreViewController ()<ZBarReaderDelegate>

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

            switch (row) {
                case 0: {
                    //扫一扫
                    ZBarReaderViewController *reader = [ZBarReaderViewController new];
                    reader.readerDelegate = self;
                    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
                    
                    ZBarImageScanner *scanner = reader.scanner;
                    
                    [scanner setSymbology: ZBAR_I25
                                   config: ZBAR_CFG_ENABLE
                                       to: 0];
                    reader.hidesBottomBarWhenPushed = YES;
                    viewController = reader;
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
                    
                    [self showWithText:@"当前是最新版本！"];
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

#pragma mark - ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    
//    label.text =  symbol.data ;
    LXLog(@"--------------------  %@",symbol.data);
    
//    if ([predicate evaluateWithObject:label.text]) {
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
//                                                        message:@"It will use the browser to this URL。"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Close"
//                                              otherButtonTitles:@"Ok", nil];
//        alert.delegate = self;
//        alert.tag=1;
//        [alert show];
//        [alert release];
//        
//        
//        
//    }
//    else if([ssidPre evaluateWithObject:label.text]){
//        
//        NSArray *arr = [label.text componentsSeparatedByString:@";"];
//        
//        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
//        
//        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
//        
//        
//        label.text=
//        [NSString stringWithFormat:@"ssid: %@ \n password:%@",
//         [arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
//        
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:label.text
//                                                        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Close"
//                                              otherButtonTitles:@"Ok", nil];
//        
//        
//        alert.delegate = self;
//        alert.tag=2;
//        [alert show];
//        [alert release];
    
//        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
//        pasteboard.string = [arrInfoFoot objectAtIndex:1];
    
        
//    }
}


@end
