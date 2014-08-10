//
//  LXResultModel.m
//  Chemayiforshops
//
//  Created by Bird on 14-6-12.
//  Copyright (c) 2014年 LianXian. All rights reserved.
//

#import "LXResultModel.h"

@implementation LXResultModel

- (id)init
{
    self = [super init];
    if (nil != self){
        _objMapDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil];
    }
    return self;
}

-(void)dealloc
{
    [_objMapDic release],_objMapDic = nil;
    [super dealloc];
}


- (LXResultModel *)createObjectFromObjName:(NSString *)key
{
    if (nil != key && [NSNull null] != (NSNull*)key)
    {
        NSString* capitalizedClassName = [self capitalizedString:key];
        LXResultModel * object = (LXResultModel *)[[[NSClassFromString(capitalizedClassName) alloc] init] autorelease];
        NSAssert(object != nil, @"Create object failed");
        return object;
    } else {
        return nil;
    }
}

- (void)setModelFromValue:(id)dataStr
{
    LXLog(@"---------Start Structure:%@---------",[self class])
    if ([dataStr isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dataDic= (NSDictionary *)dataStr;
        for (NSString *key in [dataDic allKeys])
        {
            id value = [dataDic objectForKey:key];
            
            //----dataDic value 是数组
            if ([value isKindOfClass:[NSArray class]])
            {
                [self setModelFromArray:(NSArray *)value withKey:key];
            }
            
            //----dataDic value 是 字典
            else if ([value isKindOfClass:[NSDictionary class]])
            {
                //FIXME: 这里需要补充或修改  查看这里内存是否需要释放？
                LXResultModel *object = [self valueForKeyPath:[NSString stringWithFormat:@"self.%@",key]];
                [object setModelFromValue:(NSDictionary *)value];
                LXLog(@"Setobj:%@forkey:%@",(NSString *)value,key);
            }
            
            //----dataDic value 是 字符串、数字或其他
            else
            {
                if (value != nil && value != [NSNull null])
                {
                    if ([value isKindOfClass:[NSString class]])
                    {
                        if ([self.allKeys containsObject:key])
                        {
                            //FIXME: 这里需要补充或修改   加上输出 类名。
//                            LXLog(@"Setvalue:%@forkey:%@",(NSString *)value,key);
                            [self setValue:(NSString *)value forKey:key];
                        }
                        else
                        {
                            LXLog(@"!!Model doesn't contain key:%@",key);
                        }
                    }
                    else if ([value isKindOfClass:[NSNumber class]])
                    {
                        if ([self.allKeys containsObject:key])
                        {
//                            LXLog(@"Setvalue:%@forkey:%@",[value stringValue],key);
                            [self setValue:[value stringValue] forKey:key];
                        }
                        else
                        {
                            LXLog(@"!!Model doesn't contain key:%@",key);
                        }
                    }
                    else
                    {
                        LXLog(@"!!Value contains invalude string");
                    }
                }
            }
        }
    }
    else if([dataStr isKindOfClass:[NSArray class]])
    {
        [self setModelFromArray:(NSArray *)dataStr withKey:@"dataArray"];
    }
    else
    {
        LXLog(@"!!Data contains invalude string");
    }
    LXLog(@"---------%@ Structure End---------",[self class])
}

- (void)setModelFromArray:(NSArray *)dataArray withKey:(NSString *)key
{
    if ([dataArray count] > 0)
    {
        id subValue = [dataArray objectAtIndex:0];
        
        //不允许数组嵌套数组
        if ([subValue isKindOfClass:[NSArray class]])
        {
            NSAssert(FALSE, @"You can't insert array into array");
        }
        
        //如果数组元素是Dictionary就生成相应的obj数组
        else if ([subValue isKindOfClass:[NSDictionary class]])
        {
            if ([self.allKeys containsObject:key])
            {
                NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:nil];
                for (NSDictionary *subDict in dataArray)
                {
                    NSString *objName = [self.objMapDic objectForKey:key];
                    if (objName!=nil)
                    {
                        LXResultModel *object =[self createObjectFromObjName:objName];
                        [object setModelFromValue:subDict];
                        [array addObject:object];
                    }
                }
                [self setValue:array forKey:key];
                [array release];
                //                        LXLog(@"SetObjArray:%@forkey:%@",(NSString *)value,key);
            }
            else
            {
                LXLog(@"!!Model doesn't contain ObjArrykey:%@",key);
            }
        }
        
        //如果数组元素是字符则直接生成数字或字符数组
        else
        {
            if ([self.allKeys containsObject:key])
            {
                //                        LXLog(@"SetStrArray:%@forkey:%@",(NSString *)value,key);
                [self setValue:dataArray forKey:key];
            }
            else
            {
                LXLog(@"!!Model doesn't contain Arrykey:%@",key);
            }
        }
    }
    else
    {
        LXLog(@"!!Model contain nil arry:%@",key);
    }
}

@end
