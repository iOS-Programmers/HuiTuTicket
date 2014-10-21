//
//  HTHomeDetailSceneDesVC.m
//  HuiTuTicket
//
//  Created by Bird on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeDetailSceneDesVC.h"

@interface HTHomeDetailSceneDesVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HTHomeDetailSceneDesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.detail;
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
