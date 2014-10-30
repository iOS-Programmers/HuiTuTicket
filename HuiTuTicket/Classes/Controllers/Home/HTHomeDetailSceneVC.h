//
//  HTHomeDetailSceneVC.h
//  HuiTuTicket
//
//  Created by Bird on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"

@interface HTHomeDetailSceneVC : HTBaseTableViewController
@property (nonatomic, strong) NSString *scenicId;


@property (strong, nonatomic) IBOutlet UIView *orderView;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;

@property (assign, nonatomic)BOOL isOpen;

- (IBAction)orderAction:(id)sender;

@end
