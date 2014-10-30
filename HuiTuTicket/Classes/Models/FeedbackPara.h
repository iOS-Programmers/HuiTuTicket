//
//  FeedbackPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface FeedbackPara : LXParameterModel

/**
 *  反馈类型  1-建议 2-投诉
 */
@property (strong, nonatomic) NSString *ftype;

/**
 *  用户手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  反馈内容 限制1000个字符，500个汉字
 */
@property (strong, nonatomic) NSString *content;
@end
