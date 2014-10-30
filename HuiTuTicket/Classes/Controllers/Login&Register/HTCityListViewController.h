//
//  HTCityListViewController.h
//  HuiTuTicket
//
//  Created by LiTong on 14/10/23.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseViewController.h"

@class HTCityListViewController;

@protocol CityListDelegate <NSObject>

- (void)controller:(HTCityListViewController *)controller city:(NSString *)city;

@end
@interface HTCityListViewController : HTBaseViewController

@property (nonatomic , assign) id<CityListDelegate> delegate;

@end
