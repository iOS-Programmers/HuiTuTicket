    //
//  LXHttpModel.m
//  CMY_iPhone
//
//  Created by Bird on 13-12-9.
//  Copyright (c) 2013年 Iceland. All rights reserved.
//

#import "LXHttpModel.h"

@interface LXHttpModel ()

@property (nonatomic, copy) HttpModelCompletionBlock completionBlock;
@property (nonatomic, copy) HttpModelFailedBlock failedBlock;

@end


@implementation LXHttpModel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.method = @"GET";
        self.dataDic = [[[NSMutableDictionary alloc] init] autorelease];
    }
    return self;
}

-(void)dealloc
{
    [_request clearDelegatesAndCancel];
    [_apiFuncName release], _apiFuncName = nil;
    [_path release],_path = nil;
    [_method release],_method = nil;
    [_resultModel release],_resultModel = nil;
    if (!FBIsEmpty(self.subModel))
    {
        [_subModel release],_subModel = nil;
    }
    if (!FBIsEmpty(self.subSubModel))
    {
        [_subSubModel release],_subSubModel = nil;
    }
    [_token release],_token = nil;
    if (!FBIsEmpty(self.request)) {
        [_request release],_request = nil;
    }
    [_dataDic release],_dataDic = nil;
    
    [_erorMessage release],_erorMessage = nil;
    
    [super dealloc];
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
//    LXLog(@"sub class not implete getDataWithCompletionBlock:failedBlock!");
}

- (NSMutableDictionary *)convertParameters:(LXParameterModel *)params
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *keys = [params allKeys];
    for (NSUInteger i = 0; i < [keys count]; i++)
    {
        NSString *key = [keys objectAtIndex:i];
        NSString *value = [params valueForKey:key];
        if (nil != value)
        {
            [dictionary setObject:value forKey:key];
        }
    }
    return dictionary;
}

- (void)getDataWithParameters:(LXParameterModel *)params
              completionBlock:(HttpModelCompletionBlock)completionBlock
                  failedBlock:(HttpModelFailedBlock)failedBlock
{
    NSMutableDictionary *dic = [self convertParameters:params];
    self.path =[NSString stringWithFormat:@"http://%@/service.php?",HOST_NAME];
    
//    if (!FBIsEmpty([LXUserInfoAD userLXToken]))
//    {
//        self.path = [NSString stringWithFormat:@"%@act=%@&token=%@",self.path,self.apiFuncName,[LXUserInfoAD userLXToken]];
//    }
//    else
//    {
//        self.path = [NSString stringWithFormat:@"%@act=%@",self.path,self.apiFuncName];
//    }
    
    for (int i=0; i<[[dic allKeys] count]; i++)
    {
        NSString *keyStr = [[dic allKeys] objectAtIndex:i];
        NSString *valueStr = [dic objectForKey:keyStr];
        self.path = [NSString stringWithFormat:@"%@&%@=%@",self.path,keyStr,valueStr];
    }
    NSString *urlStr = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlStr]] autorelease];
    self.request.delegate = self;
    [self.request setTimeOutSeconds:10];
    [self.request setNumberOfTimesToRetryOnTimeout:1];
    [self.request setCompletionBlock:completionBlock];
    [self.request setFailedBlock:failedBlock];
    if ([HTFoundationCommon networkDetect])
    {
//        LXLog(@"\nStart request path:%@",self.path);
        [self.request startAsynchronous];
    }
    else
    {
        [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不太给力哦,请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
    }
}


- (void)uploadDataWithParameters:(LXParameterModel *)params
                 completionBlock:(HttpModelCompletionBlock)completionBlock
                     failedBlock:(HttpModelFailedBlock)failedBlock
{
    NSMutableDictionary *dic = [self convertParameters:params];
    self.path =[NSString stringWithFormat:@"http://%@/service.php?",HOST_NAME];
//    self.path = [NSString stringWithFormat:@"%@act=%@&token=%@&confirm=%@",self.path,self.apiFuncName,[LXUserInfoAD userLXToken],params.confirm];
    NSString *urlStr = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIFormDataRequest *uploadRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    //[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    UIImage *img = [dic objectForKey:@"image"];
    NSData *image = UIImageJPEGRepresentation(img, 1.0);
//  添加请求内容
    [uploadRequest setData:image withFileName:[NSString stringWithFormat:@"%d.jpg",arc4random()] andContentType:@"binary/octet-stream" forKey:@"image"];
//这里的value值 需与服务器端 一致
    [uploadRequest addRequestHeader:@"Content-Type" value:@"binary/octet-stream"];
    [uploadRequest setRequestMethod:@"POST"];
    [uploadRequest setCompletionBlock:completionBlock];
    [uploadRequest setFailedBlock:failedBlock];
    [uploadRequest buildPostBody];
    [uploadRequest setDelegate:self];
    [uploadRequest startAsynchronous];
    [uploadRequest release];
}

#pragma mark----- ASIHTTPRequestDelegate
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    LXLog(@"DidReceiveResponseHeaders:%@\n",responseHeaders);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if (!FBIsEmpty(responseString))
    {
        LXLog(@"\nGet responseString:%@\n",responseString);
        self.dataDic = [responseString objectFromJSONString];
        self.erorCode = [[_dataDic objectForKey:@"error_no"] integerValue];
        if (self.erorCode == 0)
        {
            self.isValid = YES;
            LXLog(@"RequestSuccess\npath=%@\nGet responseString:%@\n",self.path,self.dataDic);
            if (!FBIsEmpty([self.dataDic objectForKey:@"data"]))
            {
                if ([[self.dataDic objectForKey:@"data"] isKindOfClass:[NSArray class]])
                {
                    [self.resultModel setModelFromArray:[self.dataDic objectForKey:@"data"] model:[self.subModel class] subModel:[self.subSubModel class]];
                }
                else
                {
                    [self.resultModel setModelFromDictionary:[self.dataDic objectForKey:@"data"] subModel:[self.subModel class] subSubModel:[self.subSubModel class]];
                }
            }
        }
        else if(self.erorCode==-151)
        {
            self.isValid = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证失效，请重新登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 151;
            [alert show];
            [alert release];
        }
        else
        {
            self.isValid = NO;
            self.erorMessage = [_dataDic objectForKey:@"error_info"];
            LXLog(@"RequestError\npath=%@\nerorCode=%d errorMessage == %@\nresponseString:%@\n",self.path,self.erorCode,self.erorMessage,self.dataDic);
        }
        if ([[_dataDic allKeys] containsObject:@"token"])
        {
            self.token = [_dataDic objectForKey:@"token"];
//            [LXUserInfoAD saveUserLXToken:self.token];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    LXLog(@"ASI请求失败,request.error = %@\n",request.error);
    [_request cancel];
//    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"数据请求失败，是否重新请求？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil] autorelease];
//    [alert show];
}

#pragma mark -
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==151)
    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:TOKEN_ERROR object:nil];
    }
    else
    {
        if (buttonIndex == 0)
        {
            //        self.request.delegate =self;
            //        [self.request startAsynchronous];
        }
        else
        {
            //FIXME: 这里需要补充或修改
        }
    }
}
@end
