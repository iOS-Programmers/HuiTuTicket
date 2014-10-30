//
//  TouchTableView.h
//  HuiTuTicket
//
//  Created by LiTong on 14/10/29.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;


@end

@interface TouchTableView : UITableView

/**
 *  显示大量数据的控件
 */
@property (nonatomic, assign) id<TouchTableViewDelegate> touchDelegate;

@end
