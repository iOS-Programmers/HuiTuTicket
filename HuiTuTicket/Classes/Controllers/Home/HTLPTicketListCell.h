//
//  HTLPTicketListCell.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/9.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPTicket;

@interface HTLPTicketListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UILabel *lpNameLB;
@property (weak, nonatomic) IBOutlet UILabel *lpScenicLabel;
@property (weak, nonatomic) IBOutlet UILabel *lpCompanyLabel;


- (void)configureWithData:(LPTicket *)ticketInfo;
@end
