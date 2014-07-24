//
//  HTMineHeaderView.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTMineHeaderViewDelegate <NSObject>

@optional
/**
 *  点击登录按钮
 */
- (void)onLogin;

@end

@interface HTMineHeaderView : UIView

+(HTMineHeaderView *)instanceHeaderView;

@property (weak, nonatomic) id<HTMineHeaderViewDelegate> delegate;

- (IBAction)onLoginBtnClick:(id)sender;


@end
