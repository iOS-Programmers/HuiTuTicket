//
//  HTMessageCell.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageDetail.h"

@interface HTMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)configureUIWithData:(MessageDetail *)detail;

@end
