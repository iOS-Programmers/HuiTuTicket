//
//  HTBaseTableViewController.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTBaseTableViewController : HTBaseViewController<UITableViewDelegate, UITableViewDataSource>

/**
 *  显示大量数据的控件
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  初始化init的时候设置tableView的样式才有效
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  去除iOS7新的功能api，tableView的分割线变成iOS6正常的样式
 */
- (void)configuraTableViewNormalSeparatorInset;

/**
 *  配置tableView右侧的index title 背景颜色，因为在iOS7有白色底色，iOS6没有
 *
 *  @param tableView 目标tableView
 */
- (void)configuraSectionIndexBackgroundColorWithTableView:(UITableView *)tableView;

/**
 *  加载本地或者网络数据源
 */
- (void)loadDataSource;

/**
 *  自定义导航栏左右按钮
 */
- (UIBarButtonItem *)createNavBtnItem:(UIViewController *)target normal:(NSString *)imgStr highlight:(NSString *)highStr selector:(SEL)selector;

@end
