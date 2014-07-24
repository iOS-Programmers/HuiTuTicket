//
//  HTTicketDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketDetailController.h"

@interface HTTicketDetailController ()

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
    }
    return self;
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
