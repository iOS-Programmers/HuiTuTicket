//
//  HTHomeDetailSceneDesVC.m
//  HuiTuTicket
//
//  Created by Bird on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeDetailSceneDesVC.h"
/**
 *  查看景区详情介绍的url
 *  http://m.huitour.cn/app/scenic/content?scenicid=
 */

#define API_Introduce_URL @"http://m.huitour.cn/app/scenic/content?scenicid="

@interface HTHomeDetailSceneDesVC ()

@end

@implementation HTHomeDetailSceneDesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"详细介绍";
    
    [self loadDataWithURL:[NSString stringWithFormat:@"%@%@",API_Introduce_URL,self.scenicId]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
