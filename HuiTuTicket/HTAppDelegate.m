//
//  HTAppDelegate.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "HTAppDelegate.h"

#import "HTBaseNavigationController.h"
#import "HTBaseTabBarController.h"

#import "HTMessageViewController.h"
#import "HTOrderViewController.h"
#import "HTHomeViewController.h"
#import "HTMineViewController.h"
#import "HTMoreViewController.h"

#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "PartnerConfig.h"
@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (CURRENT_SYS_VERSION <= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    
    //Message
    HTMessageViewController *messageViewController = [[HTMessageViewController alloc] init];
    messageViewController.title = @"消息";
    messageViewController.tabBarItem.image = [UIImage imageNamed:@"tab_message"];
    messageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_message_selected"];
    HTBaseNavigationController *messageNav = [[HTBaseNavigationController alloc] initWithRootViewController:messageViewController];
    
    //Order
    HTOrderViewController *orderViewController = [[HTOrderViewController alloc] init];
    orderViewController.title = @"订单";
    orderViewController.tabBarItem.image = [UIImage imageNamed:@"tab_order"];
    orderViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_order_selected"];
    HTBaseNavigationController *orderNav = [[HTBaseNavigationController alloc] initWithRootViewController:orderViewController];
    
    //Home
    HTHomeViewController *homeRootViewController = [[HTHomeViewController alloc] init];
    homeRootViewController.title = @"惠途假期";
    homeRootViewController.tabBarItem.image = [UIImage imageNamed:@"tab_home"];
    homeRootViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
    HTBaseNavigationController *homeRootNav = [[HTBaseNavigationController alloc] initWithRootViewController:homeRootViewController];
    
    //Mine
    HTMineViewController *mineViewController = [[HTMineViewController alloc] init];
    mineViewController.title = @"我的";
    mineViewController.tabBarItem.image = [UIImage imageNamed:@"tab_mine"];
    mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_mine_selected"];
    HTBaseNavigationController *mineNav = [[HTBaseNavigationController alloc] initWithRootViewController:mineViewController];
    
    //More
    HTMoreViewController *moreViewController = [[HTMoreViewController alloc] init];
    moreViewController.title = @"更多";
    moreViewController.tabBarItem.image = [UIImage imageNamed:@"tab_more"];
    moreViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_more_selected"];
    HTBaseNavigationController *moreNav = [[HTBaseNavigationController alloc] initWithRootViewController:moreViewController];
    
    //tabBar
    HTBaseTabBarController *rootTabBarController = [[HTBaseTabBarController alloc] init];
    rootTabBarController.viewControllers = @[messageNav,orderNav,homeRootNav,mineNav,moreNav];
    [rootTabBarController setSelectedIndex:2];
    
    // setup UI Image
    UIColor *color = UIColorToRGB(0x3fb0dc);
    
    [rootTabBarController.tabBar setSelectedImageTintColor:color];

    
    if (CURRENT_SYS_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:UIColorToRGB(0x3fb0dc)];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    } else {
        [[UINavigationBar appearance] setTintColor:UIColorToRGB(0x3fb0dc)];
        [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg"]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorToRGB(0x3fb0dc), UITextAttributeTextColor,
                                                           nil] forState:UIControlStateSelected];
    }
    
    
    
    
    self.window.rootViewController = rootTabBarController;
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parse:url application:application];
	return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    //结果处理
    AlixPayResult *result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            //交易成功
            NSString* key = AlipayPubKey;
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);

			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
			}
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:ALIPAY_DONE object:result];
}

- (AlixPayResult *)resultFromURL:(NSURL *)url
{
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url
{
	AlixPayResult * result = nil;
    
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
