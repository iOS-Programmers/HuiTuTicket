//
//  HTOrderTableViewCell.h
//  HuiTuTicket
//
//  Created by Bird on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iv;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *placeLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;


@property (weak, nonatomic) IBOutlet UIButton *orderBtn;


@end
