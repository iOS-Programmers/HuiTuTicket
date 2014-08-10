//
//  HTHomeTableViewCell.h
//  HuiTuTicket
//
//  Created by Bird on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sceneIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;

@end
