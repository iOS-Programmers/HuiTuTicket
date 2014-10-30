//
//  HTPayTableViewCell.h
//  HuiTuTicket
//
//  Created by Bird on 14/10/29.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *zhankaiBtn;



@end
