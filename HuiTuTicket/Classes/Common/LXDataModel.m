//
//  LXDataModel.m
//  Chemayi
//
//  Created by Bird on 14-3-19.
//  Copyright (c) 2014年 Chemayi. All rights reserved.
//

#import "LXDataModel.h"
#import <objc/runtime.h>

static NSMutableDictionary *keyNames = nil; // key names for all subclass of ModelObject

@implementation LXDataModel
#pragma mark - init

// Before this class is first accessed, we'll need to build up our associated metadata, basically
// just a list of all our property names so we can quickly enumerate through them for various methods.
+ (void)initialize {
    
	if (nil == keyNames) {
        keyNames = [NSMutableDictionary new];
    }
    
	NSMutableArray *names = [NSMutableArray new];
    
    //保存从ModelObject往下的所有父子关系中keys
    //比如News继承至ModelObject，VideoNews继承至News，则VideoNews中必须保存News中的所有keys
	for (Class cls = self; cls!= [LXDataModel class]; cls = [cls superclass])
    {
		unsigned int varCount;
		Ivar *vars = class_copyIvarList(cls, &varCount);
		
		for (unsigned int i = 0; i < varCount; i++)
        {
			Ivar var = vars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(var)];
			[names addObject:[name substringFromIndex:1]];
			[name release];
		}
		free(vars);
	}
	[keyNames setObject:names forKey:NSStringFromClass([self class])];
	[names release];
}

- (NSMutableDictionary *)convertToDictionary
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:nil] autorelease];
    for (NSString *key in [self allKeys])
    {
        id value = [self valueForKey:key];
        if (nil != value && [NSNull null] != value)
        {
            if ([value isKindOfClass:[NSString class]])
            {
                [dic setObject:(NSString *)value forKey:key];
            }
            else if ([value isKindOfClass:[NSNumber class]])
            {
                [dic setObject:[value stringValue] forKey:key];
            }
            else if([value isKindOfClass:[NSMutableArray class]])
            {
                for (id subValue in (NSArray *)value)
                {
                    NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
                    if ([subValue isKindOfClass:[LXDataModel class]])
                    {
                        NSDictionary *subDic =[subValue convertToDictionary];
                        [array addObject:subDic];
                    }
                    [dic setObject:array forKey:key];
                }
            }
            else
            {
                LXLog(@"Check value type");
            }
        }
    }
    return  dic;
}

- (NSArray*)allKeys
{
	return [keyNames objectForKey:NSStringFromClass([self class])];
}

- (NSString *)capitalizedString:(NSString *)string
{
    if (!FBIsEmpty(string))
    {
        return [string stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string substringToIndex:1] uppercaseString]];
    }
    return nil;
}

- (LXDataModel *)createObjectFromKey:(NSString *)key
{
    if (nil != key && [NSNull null] != (NSNull*)key)
    {
        NSString* capitalizedClassName = [self capitalizedString:key];
        LXDataModel * object = (LXDataModel *)[[[NSClassFromString(capitalizedClassName) alloc] init] autorelease];
        NSAssert(object != nil, @"create object failed");
        return object;
    } else {
        return nil;
    }
}


- (void)setModelFromDataDic:(NSDictionary *)dataDic
{
/*
    for (NSString *key in [self allKeys])
    {
        id value = [dataDic objectForKey:key];
        //model 元素 是数组
        if ([value isKindOfClass:[NSArray class]])
        {
            id arraykeyValue = [dataDic objectForKey:key];
            if ([arraykeyValue isKindOfClass:[NSArray class]])
            {
                
            }
            
            
            if ([(NSArray *)value count] > 0)
            {
                
                
                
                
                id subValue = [(NSArray *)value objectAtIndex:0];
                
                // 不允许数组嵌套数组
                if ([subValue isKindOfClass:[NSArray class]])
                {
                    NSAssert(FALSE, @"you can't insert array into array");
                }
                
                // 如果是dictionary就生成相应的model
                else if ([subValue isKindOfClass:[NSDictionary class]])
                {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:nil];
                    for (NSDictionary *subDict in (NSArray *)value)
                    {
//                        if (subModel!=nil)
//                        {
//                            LXDataModel *object =[self createObjectFromKey:NSStringFromClass(subModel)];
//                            [object setModelFromDictionary:subDict subModel:subSubmodel];
//                            [array addObject:object];
//                        }
                    }
                    if ([self.allKeys containsObject:key])
                    {
                        //                        LXLog(@"SetObjArray:%@forkey:%@",(NSString *)value,key);
                        [self setValue:array forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain ObjArrykey:%@",key);
                    }
                    [array release];
                }
                else
                {
                    if ([self.allKeys containsObject:key])
                    {
                        LXLog(@"SetArray:%@forkey:%@",(NSString *)value,key);
                        [self setValue:(NSArray *)value forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain Arrykey:%@",key);
                    }
                }
            }
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            LXDataModel *object = [self valueForKeyPath:[NSString stringWithFormat:@"self.%@",key]];
            [object setModelFromDictionary:(NSDictionary *)value subModel:subModel];
            //            [self setValue:object forKeyPath:[NSString stringWithFormat:@"self.%@",key]];
        }
        else
        {
            if (nil != value && [NSNull null] != value)
            {
                if ([value isKindOfClass:[NSString class]])
                {
                    if ([self.allKeys containsObject:key])
                    {
                        //                        LXLog(@"Setvalue:%@forkey:%@",(NSString *)value,key);
                        [self setValue:(NSString *)value forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain key:%@",key);
                    }
                }
                else if ([value isKindOfClass:[NSNumber class]])
                {
                    if ([self.allKeys containsObject:key])
                    {
                        //                        LXLog(@"Setvalue:%@forkey:%@",[value stringValue],key);
                        [self setValue:[value stringValue] forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain key:%@",key);
                    }
                }
                else
                {
                    LXLog(@"!!value contains invalude str");
                }
            }
        }
    }\
 */
}

- (void)setModelFromDictionary:(NSDictionary *)dict subModel:(Class)subModel subSubModel:(Class)subSubmodel
{
//    LXLog(@"\n%@ setModelFromDictionary",NSStringFromClass([self class]));
    for (NSString *key in [dict allKeys])
    {
        id value = [dict objectForKey:key];
        
        if ([value isKindOfClass:[NSArray class]])
        {
            if ([(NSArray *)value count] > 0)
            {
                id subValue = [(NSArray *)value objectAtIndex:0];
                
                // 不允许数组嵌套数组
                if ([subValue isKindOfClass:[NSArray class]])
                {
                    NSAssert(FALSE, @"you can't insert array into array");
                }
                
                // 如果是dictionary就生成相应的model
                else if ([subValue isKindOfClass:[NSDictionary class]])
                {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:nil];
                    for (NSDictionary *subDict in (NSArray *)value)
                    {
                        if (subModel!=nil)
                        {
                            LXDataModel *object =[self createObjectFromKey:NSStringFromClass(subModel)];
                            [object setModelFromDictionary:subDict subModel:subSubmodel];
                            [array addObject:object];
                        }
                    }
                    if ([self.allKeys containsObject:key])
                    {
                        LXLog(@"SetObjArray:%@forkey:%@",(NSString *)value,key);
                        [self setValue:array forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain ObjArrykey:%@",key);
                    }
                    [array release];
                }
                else
                {
                    if ([self.allKeys containsObject:key])
                    {
                        LXLog(@"SetArray:%@forkey:%@",(NSString *)value,key);
                        [self setValue:(NSArray *)value forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain Arrykey:%@",key);
                    }
                }
            }
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            LXDataModel *object = [self valueForKeyPath:[NSString stringWithFormat:@"self.%@",key]];
            [object setModelFromDictionary:(NSDictionary *)value subModel:subModel];
            //            [self setValue:object forKeyPath:[NSString stringWithFormat:@"self.%@",key]];
        }
        else
        {
            if (nil != value && [NSNull null] != value)
            {
                if ([value isKindOfClass:[NSString class]])
                {
                    if ([self.allKeys containsObject:key])
                    {
                        LXLog(@"Setvalue:%@forkey:%@",(NSString *)value,key);
                        [self setValue:(NSString *)value forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain key:%@",key);
                    }
                }
                else if ([value isKindOfClass:[NSNumber class]])
                {
                    if ([self.allKeys containsObject:key])
                    {
                        LXLog(@"Setvalue:%@forkey:%@",[value stringValue],key);
                        [self setValue:[value stringValue] forKey:key];
                    }
                    else
                    {
                        LXLog(@"!!result model doesn't contain key:%@",key);
                    }
                }
                else
                {
                    LXLog(@"!!value contains invalude str");
                }
            }
        }
    }
}

- (void)setModelFromDictionary:(NSDictionary *)dict subModel:(Class)subModel
{
    [self setModelFromDictionary:dict subModel:subModel subSubModel:nil];
}

- (void)setModelFromArray:(NSArray *)dataArray model:(Class)model subModel:(Class)subModel
{
//    LXLog(@"\n%@ setModelFromArray",NSStringFromClass([self class]));
    NSString *arraykey = @"dataArray";
    if ([dataArray count] > 0)
    {
        id subValue = [dataArray objectAtIndex:0];
        
        // 不允许数组嵌套数组
        if ([subValue isKindOfClass:[NSArray class]])
        {
            NSAssert(FALSE, @"you can't insert array into array");
        }
        
        // 如果是dictionary就生成相应的model
        else if ([subValue isKindOfClass:[NSDictionary class]])
        {
            NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:nil];
            for (NSDictionary *subDict in dataArray)
            {
                if (model!=nil)
                {
                    LXDataModel *object =[self createObjectFromKey:NSStringFromClass(model)];
                    [object setModelFromDictionary:subDict subModel:subModel];
                    [array addObject:object];
                }
            }
            if ([self.allKeys containsObject:arraykey])
            {
//                LXLog(@"SetObjArray:%@forkey:%@",subValue,arraykey);
                [self setValue:array forKey:arraykey];
            }
            else
            {
                LXLog(@"!!result model doesn't contain ObjArrykey:%@",arraykey);
            }
            [array release];
        }
        else
        {
            if ([self.allKeys containsObject:arraykey])
            {
//                LXLog(@"SetArray:%@forkey:%@",subValue,arraykey);
                [self setValue:subValue forKey:arraykey];
            }
            else
            {
                LXLog(@"!!result model doesn't contain Arrykey:%@",arraykey);
            }
        }
    }
    else
    {
        LXLog(@"!!Result dataArray is null");
    }
}


- (void)setModelFromArray:(NSArray *)dataArray subModel:(Class)subModel
{
    [self setModelFromArray:dataArray model:subModel subModel:nil];
}

#pragma mark - NSCoder

// NSCoder implementation, for unarchiving
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
		for (NSString *name in [self allKeys])
			[self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
	}
	return self;
}

// NSCoder implementation, for archiving
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
	for (NSString *name in [self allKeys]) {
        id object = [self valueForKey:name];
        if ([object conformsToProtocol:@protocol(NSCoding)]) {
            [aCoder encodeObject:[self valueForKey:name] forKey:name];
        }
    }
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark - copy

// NSCopying implementation
- (id)copyWithZone:(NSZone *)zone {
	
	id copied = [[[self class] alloc] init];
	
	for (NSString *name in [self allKeys])
		[copied setValue:[self valueForKey:name] forKey:name];
	
	return copied;
}

#pragma mark - fast enumeration

// We implement the NSFastEnumeration protocol to behave like an NSDictionary - the enumerated values are our property (key) names.
// https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocFastEnumeration.html#//apple_ref/doc/uid/TP30001163-CH18
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	return [[self allKeys] countByEnumeratingWithState:state objects:stackbuf count:len];
}

#pragma mark - equal

// Override isEqual to compare model objects by value instead of just by pointer.
- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
	if ([other isKindOfClass:[self class]]) {
		for (NSString *name in [self allKeys]) {
			id a = [self valueForKey:name];
			id b = [other valueForKey:name];
			
			// extra check so a == b == nil is considered equal
            // 否则的话a==nil的情况下，无论b是否nil，[a isEqual:b] == nil
			if ((a || b) && ![a isEqual:b]) {
                return NO;
            }
		}
		return YES;
	} else {
        return NO;
    }
}

// Must override hash as well, this is taken directly from RMModelObject, basically
// classes with the same layout return the same number.
- (NSUInteger)hash {
	return (NSUInteger)[self allKeys];
    
}

#pragma mark - description

- (void)writeLineBreakToString:(NSMutableString *)string withTabs:(NSUInteger)tabCount {
	[string appendString:@"\n"];
	for (int i=0;i<tabCount;i++) [string appendString:@"\t"];
}

// Prints description in a nicely-formatted and indented manner.
- (void)writeToDescription:(NSMutableString *)description withIndent:(NSUInteger)indent {
	
	[description appendFormat:@"<%@ %p", NSStringFromClass([self class]), self];
	
	for (NSString *name in [self allKeys]) {
		
		[self writeLineBreakToString:description withTabs:indent];
		
		id object = [self valueForKey:name];
		
		if ([object isKindOfClass:[LXDataModel class]]) {
			[object writeToDescription:description withIndent:indent+1];
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id child in object) {
				[self writeLineBreakToString:description withTabs:indent+1];
				
				if ([child isKindOfClass:[LXDataModel class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else if ([object isKindOfClass:[NSDictionary class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id key in object) {
				[self writeLineBreakToString:description withTabs:indent];
                [description appendFormat:@"\t%@ = ",key];
                
				id child = [object objectForKey:key];
				
				if ([child isKindOfClass:[LXDataModel class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else {
			[description appendFormat:@"%@ = %@", name, object];
		}
	}
    
	[description appendString:@">"];
}

// Override description for helpful debugging.
- (NSString*)description {
	NSMutableString *description = [NSMutableString string];
	[self writeToDescription:description withIndent:1];
    
	return description;
}
@end
