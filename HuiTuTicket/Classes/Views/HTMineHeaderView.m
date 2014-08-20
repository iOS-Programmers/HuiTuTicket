//
//  HTMineHeaderView.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMineHeaderView.h"

@implementation HTMineHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(HTMineHeaderView *)instanceHeaderView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HTMineHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (IBAction)onLoginBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onLogin)]) {
        [self.delegate onLogin];
    }
}
- (IBAction)onAvatarClick:(id)sender
{
    if (self.canClick) {
        
        if ([self.delegate respondsToSelector:@selector(onLogin)]) {
            [self.delegate clickAvatar];
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    self.canClick = NO;
}


@end
