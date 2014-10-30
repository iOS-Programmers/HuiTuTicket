//
//  GetUserInfo.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "GetUserInfo.h"

@implementation GetUserInfo

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.userid      forKey:@"userid"];
    [aCoder encodeObject:self.mobile      forKey:@"mobile"];
    [aCoder encodeObject:self.headpic      forKey:@"headpic"];
    [aCoder encodeObject:self.nickname     forKey:@"nickname"];
    [aCoder encodeObject:self.sex      forKey:@"sex"];
    [aCoder encodeObject:self.realname      forKey:@"realname"];
    [aCoder encodeObject:self.email      forKey:@"email"];
    [aCoder encodeObject:self.city     forKey:@"city"];
    [aCoder encodeObject:self.regtime     forKey:@"regtime"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.userid       = [aDecoder decodeObjectForKey:@"userid"];
        self.mobile   = [aDecoder decodeObjectForKey:@"mobile"];
        self.headpic       = [aDecoder decodeObjectForKey:@"headpic"];
        self.nickname      = [aDecoder decodeObjectForKey:@"nickname"];
        self.sex       = [aDecoder decodeObjectForKey:@"sex"];
        self.realname   = [aDecoder decodeObjectForKey:@"realname"];
        self.email       = [aDecoder decodeObjectForKey:@"email"];
        self.city      = [aDecoder decodeObjectForKey:@"city"];
        self.regtime      = [aDecoder decodeObjectForKey:@"regtime"];
    }
    
    return self;
}
@end
