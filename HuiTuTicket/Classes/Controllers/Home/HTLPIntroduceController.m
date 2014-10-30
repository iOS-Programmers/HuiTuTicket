//
//  HTLPIntroduceController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPIntroduceController.h"

@interface HTLPIntroduceController ()
{
    NSString *urlString;
}

@end

@implementation HTLPIntroduceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.type isEqualToString:@"1"]) {
        urlString = [NSString stringWithFormat:@"http://m.huitour.cn/app/lp/jieshao"];
        self.title = @"联票介绍";
    }
    if ([self.type isEqualToString:@"2"]) {
        urlString = [NSString stringWithFormat:@"http://m.huitour.cn/app/lp/huoqu"];
        self.title = @"获取联票";
    }
    if ([self.type isEqualToString:@"3"]) {
        urlString = [NSString stringWithFormat:@"http://m.huitour.cn/app/lp/xuzhi"];
        self.title = @"使用须知";
    }
    
    [self loadDataWithURL:urlString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
