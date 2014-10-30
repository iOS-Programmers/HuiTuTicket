//
//  HTHomeTableViewCell.h
//  HuiTuTicket
//
//  Created by Bird on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceLable.h"
@interface HTHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sceneIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLab;//省标签
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;// 市标签
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格标签


@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;//原价格标签
@property (weak, nonatomic) PriceLable *oldPriceLab;//原价格标签(修改)

@end
