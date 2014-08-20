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

/**
 *  点击头像区域
 */
- (void)clickAvatar;

@end

@interface HTMineHeaderView : UIView

+(HTMineHeaderView *)instanceHeaderView;

@property (weak, nonatomic) id<HTMineHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginAlertLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic) BOOL canClick;

- (IBAction)onLoginBtnClick:(id)sender;


@end
