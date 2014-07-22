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


@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Message
    HTMessageViewController *messageViewController = [[HTMessageViewController alloc] init];
    messageViewController.title = @"消息";
    messageViewController.tabBarItem.image = [UIImage imageNamed:@"tab_message"];
    HTBaseNavigationController *messageNav = [[HTBaseNavigationController alloc] initWithRootViewController:messageViewController];
    
    //Order
    HTOrderViewController *orderViewController = [[HTOrderViewController alloc] init];
    orderViewController.title = @"订单";
    orderViewController.tabBarItem.image = [UIImage imageNamed:@"tab_order"];
    HTBaseNavigationController *orderNav = [[HTBaseNavigationController alloc] initWithRootViewController:orderViewController];
    
    //Home
    HTHomeViewController *homeRootViewController = [[HTHomeViewController alloc] init];
    homeRootViewController.title = @"主页";
    homeRootViewController.tabBarItem.image = [UIImage imageNamed:@"tab_home"];
    HTBaseNavigationController *homeRootNav = [[HTBaseNavigationController alloc] initWithRootViewController:homeRootViewController];
    
    //Mine
    HTMineViewController *mineViewController = [[HTMineViewController alloc] init];
    mineViewController.title = @"我的";
    mineViewController.tabBarItem.image = [UIImage imageNamed:@"tab_mine"];
    HTBaseNavigationController *mineNav = [[HTBaseNavigationController alloc] initWithRootViewController:mineViewController];
    
    //More
    HTMoreViewController *moreViewController = [[HTMoreViewController alloc] init];
    moreViewController.title = @"更多";
    moreViewController.tabBarItem.image = [UIImage imageNamed:@"tab_more"];
    HTBaseNavigationController *moreNav = [[HTBaseNavigationController alloc] initWithRootViewController:moreViewController];
    
    //tabBar
    HTBaseTabBarController *rootTabBarController = [[HTBaseTabBarController alloc] init];
    rootTabBarController.viewControllers = @[messageNav,orderNav,homeRootNav,mineNav,moreNav];
    [rootTabBarController setSelectedIndex:2];
    
    // setup UI Image
    UIColor *color = UIColorToRGB(0x3fb0dc);
//    [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBkg"]];
    [rootTabBarController.tabBar setSelectedImageTintColor:color];
    
    if (CURRENT_SYS_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:UIColorToRGB(0x3fb0dc)];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
        [[UINavigationBar appearance] setTintColor:UIColorToRGB(0x3fb0dc)];
    }
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
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

@end
