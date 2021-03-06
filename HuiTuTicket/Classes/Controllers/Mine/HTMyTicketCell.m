//
//  HTMyTicketCell.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMyTicketCell.h"
#import "MyTicket.h"

@implementation HTMyTicketCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(MyTicket *)info
{
    if (info) {
        self.lpCodeLabel.text = info.lpcode;
        self.lpTimeLabel.text = info.regtime;
        [self.imgView setImageWithURL:[NSURL URLWithString:info.typepic] placeholderImage:[UIImage imageNamed:@"mine_header_bg.png"]];
        self.lpNameLabel.text = info.typename;
        LXLog(@"%@",info.typename);
        self.lpUserLabel.text = [NSString stringWithFormat:@"注册人：%@",info.lpuser];
        self.lpEndtimeLabel.text = [NSString stringWithFormat:@"有效期：%@ 年",info.endtime];
    }
}

@end
