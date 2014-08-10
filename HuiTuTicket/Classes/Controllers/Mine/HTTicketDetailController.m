//
//  HTTicketDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketDetailController.h"

#import "TicketDetailHttp.h"

@interface HTTicketDetailController ()

@property (strong, nonatomic) TicketDetailHttp *detailHttp;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)segementChanged:(id)sender;
@end

@implementation HTTicketDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票详情";
        
        _detailHttp = [[TicketDetailHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(640, 500)];

    [self requestDetailData];
}

- (void)requestDetailData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketDetailController *weak_self = self;
    
    self.detailHttp.parameter.typeid = @"5";
    
    [self.detailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.detailHttp.isValid) {
            [weak_self showWithText:@"联票详情请求成功"];
//            weak_self.dataSource = weak_self.detailHttp.resultModel.info;
//            [weak_self.tableView reloadData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.detailHttp.erorMessage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segementChanged:(id)sender
{
    UISegmentedControl *segement = (UISegmentedControl *)sender;

    switch (segement.selectedSegmentIndex) {
        case 0:
        {
            //联票详情
            [self.scrollView setContentOffset:CGPointMake(0, 0)];
        }
            break;
        case 1:
        {
            //二维码
            [self.scrollView setContentOffset:CGPointMake(320, 0)];
        }
            break;
            
        default:
            break;
    }
}
@end
