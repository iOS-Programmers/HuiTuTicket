//
//  HTLPSceneTableViewCell.h
//  HuiTuTicket
//
//  Created by Bird on 14-8-20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTLPSceneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLimit;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *levelLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *flagLB;





@end
