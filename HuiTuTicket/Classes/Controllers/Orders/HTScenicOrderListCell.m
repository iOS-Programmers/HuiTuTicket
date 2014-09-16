//
//  HTScenicOrderListCell.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTScenicOrderListCell.h"
#import "TicketOrderModel.h"

@implementation HTScenicOrderListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(TicketOrderModel *)info
{
    if ([info isKindOfClass:[TicketOrderModel class]]) {
        self.scenicName.text = info.scenicName;
        self.tourTime.text = [NSString stringWithFormat:@"出游日期：%@",info.traveltime];

        self.orderTime.text = [NSString stringWithFormat:@"下单日期：%@",info.addtime];
        
        self.price.text = [NSString stringWithFormat:@"￥%@",info.totalamount];
        
        self.orderStatus.text = [info.ispay isEqualToString:@"0"] ? @"未支付" : @"已支付";
    }
    
    
}

@end
