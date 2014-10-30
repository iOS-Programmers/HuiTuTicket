//
//  HTCityListViewController.m
//  HuiTuTicket
//
//  Created by LiTong on 14/10/23.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTCityListViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"

@interface HTCityListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{
    NSDictionary *_citysDic;
    NSArray *_keys;
    UISearchBar *_searchBar;
    
    UISearchDisplayController *_seachDis;
    NSMutableArray *_searchResult;
}


@end

@implementation HTCityListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"选择城市";    }
    return self;
}
//返回按钮
- (void)configuraBackButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
}
#pragma mark - Action
- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//确定按钮
- (void)configuraOkButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configuraBackButton];
    [self configuraOkButton];
    
    //从本地取出城市数据
    NSDictionary *citysDic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citydict.plist" ofType:nil]];
    _citysDic = citysDic;
    NSArray *keys = [[citysDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _keys = keys;
    
    NSMutableArray *searchResult = [[NSMutableArray alloc] initWithCapacity:0];
    _searchResult = searchResult;
    
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:(CGRect){{0,0},{320,44}}];
    searchBar.placeholder = @"请输入";
    searchBar.delegate = self;
    //[self.view addSubview:searchBar];
    _searchBar = searchBar;
    
    
    
    CGRect farme = [UIScreen mainScreen].bounds;
    NSLog(@"%f ,%f",farme.size.width,farme.size.height);
    
    //城市列表
    CGRect bounds = [UIScreen mainScreen].bounds;
    UITableView *cityList = [[UITableView alloc] initWithFrame:(CGRect){{0,0},{320,bounds.size.height-4}} style:(UITableViewStyleGrouped)];
    cityList.delegate = self;
    cityList.dataSource = self;
    cityList.sectionFooterHeight = 0;
    cityList.tableHeaderView = searchBar;
    
    if (CURRENT_SYS_VERSION >= 7) {
        cityList.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:cityList];
    [cityList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UISearchDisplayController *searchDis = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    searchDis.delegate = self;
    searchDis.active = NO;
    [searchDis setSearchResultsDataSource:self];
    [searchDis setSearchResultsDelegate:self];
    [searchDis.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _seachDis = searchDis;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _seachDis.searchResultsTableView) {
        return 1;
    }else
    {
        return _keys.count;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _seachDis.searchResultsTableView) {
        return _searchResult.count;
    }else
    {
        NSString *key = _keys[section];
        NSArray *citys = _citysDic[key];
        return citys.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (tableView == _seachDis.searchResultsTableView) {
        cell.textLabel.text = _searchResult[indexPath.row];
    }else
    {
        NSString *key = _keys[indexPath.section];
        NSArray *citys = _citysDic[key];
        cell.textLabel.text = citys[indexPath.row];
    }
    
    return cell;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _seachDis.searchResultsTableView) {
        return nil;
    }else
    {
        return _keys;
    }
}
#pragma mark -Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _seachDis.searchResultsTableView) {
        NSString *city = _searchResult[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(controller:city:)]) {
            [self.delegate controller:self city:city];
        }
        [self back];

    }else{
        NSString *key = _keys[indexPath.section];
        NSArray *citys = _citysDic[key];
        NSString *city = citys[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(controller:city:)]) {
            [self.delegate controller:self city:city];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _seachDis.searchResultsTableView) {
        return nil;
    }else
    {
        NSString *key = _keys[section];
        
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){{0,0},{320,20}}];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:(CGRect){{10,0},{100,20}}];
        titleLab.text = key;
        titleLab.backgroundColor = [UIColor clearColor];
        [view addSubview:titleLab];
        
        return view;
    }
    
    
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _seachDis.searchResultsTableView) {
        return 0;
    }else
    {
        return 20;
    }
    
}
#pragma mark - UISearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_searchResult removeAllObjects];
    if (searchText.length > 0 && ![ChineseInclude isIncludeChineseInString:searchText]) {//有输入并且输入不为汉字
        for (NSString *cityStr in _keys) {
            NSArray *citys = [_citysDic objectForKey:cityStr];
            for (NSString *cityStr in citys) {//取出要匹配的数据
                if ([ChineseInclude isIncludeChineseInString:cityStr]) {//如果数据是拼音
                    NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:cityStr];//转化为拼音
                    NSRange titleResult = [tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleResult.length > 0) {
                        [_searchResult addObject:cityStr];
                    }
                    NSString *tempPinYinHead = [PinYinForObjc chineseConvertToPinYinHead:cityStr];//转化为拼音的首字母
                    NSRange titleHeadResult = [tempPinYinHead rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleHeadResult.length) {
                        [_searchResult addObject:cityStr];
                    }
                }
                else//如果数据不是拼音
                {
                    NSRange titleResult = [cityStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleResult.length > 0) {
                        [_searchResult addObject:cityStr];
                    }
                }
            }
        }
    }else if(searchText.length > 0 && [ChineseInclude isIncludeChineseInString:searchText])//有输入并且输入为汉字
    {
        for (NSString *cityStr in _keys) {
            NSArray *citys = [_citysDic objectForKey:cityStr];
            for (NSString *cityStr in citys) {
                
                NSRange titleResult = [cityStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [_searchResult addObject:cityStr];
                }
            }
        }
    }
}


@end
