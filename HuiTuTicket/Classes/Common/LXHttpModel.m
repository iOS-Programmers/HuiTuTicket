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
        self.method = @"POST";
        
        #warning 这个api_url默认的是会员注册的接口的，其他接口调用的时候要在子类里重新设置下
        self.api_url = @"m-test.huitupiaowu.com/index.php/member";
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
    LXLog(@"sub class not implete getDataWithCompletionBlock:failedBlock!");
}

/**
 *  把入参对象转换成字典的形式
 *
 *  @param params 入参对象
 *
 *  @return 返回对应的字典
 */
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

/**
 *  请求接口用到的方法
 *
 *  @param params           入参 （为一个对象）
 *  @param completionBlock  请求成功处理方法
 *  @param failedBlock      请求失败处理方法
 */
- (void)getDataWithParameters:(LXParameterModel *)params
              completionBlock:(HttpModelCompletionBlock)completionBlock
                  failedBlock:(HttpModelFailedBlock)failedBlock
{
    NSMutableDictionary *dic = [self convertParameters:params];
    /**
     *   请求地址格式 http://API_URL?method=user.register&api_key={接口秘钥}
     */
    self.path =[NSString stringWithFormat:@"http://%@?method=%@&api_key=%@",self.api_url,self.apiFuncName,API_KEY];
    NSString *urlStr = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlStr]] autorelease];
    self.request.delegate = self;
    self.request.requestMethod = self.method;
    
    for (int i=0; i<[[dic allKeys] count]; i++)
    {
        NSString *keyStr = [[dic allKeys] objectAtIndex:i];
        NSString *valueStr = [dic objectForKey:keyStr];
        
        
        [self.request setPostValue:valueStr forKey:keyStr];

//        [self.request setValue:valueStr forKey:keyStr];
        //        self.path = [NSString stringWithFormat:@"%@&%@=%@",self.path,keyStr,valueStr];
    }
    
    [self.request setTimeOutSeconds:10];
    [self.request setNumberOfTimesToRetryOnTimeout:1];
    [self.request setCompletionBlock:completionBlock];
    [self.request setFailedBlock:failedBlock];
    if ([HTFoundationCommon networkDetect])
    {
        LXLog(@"\n\n\nStart request path:\n\n%@\n\n",self.path);
        [self.request startAsynchronous];
    }
    else
    {
        [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不太给力哦,请检查网络!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
    }
}

/**
 *  上传用到的方法
 *
 *  @param params          入参 （为一个对象）
 *  @param completionBlock 请求成功处理方法
 *  @param failedBlock     请求失败处理方法
 */
- (void)uploadDataWithParameters:(LXParameterModel *)params
                 completionBlock:(HttpModelCompletionBlock)completionBlock
                     failedBlock:(HttpModelFailedBlock)failedBlock
{
    NSMutableDictionary *dic = [self convertParameters:params];
    self.path =[NSString stringWithFormat:@"http://%@/service.php?",HOST_NAME];

    NSString *urlStr = [self.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIFormDataRequest *uploadRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];

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
//    LXLog(@"DidReceiveResponseHeaders:%@\n",responseHeaders);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if (!FBIsEmpty(responseString))
    {
        LXLog(@"\nGet responseString:\n%@\n",responseString);
        self.dataDic = [responseString objectFromJSONString];
        self.erorCode = [[_dataDic objectForKey:@"errcode"] integerValue];
        if (self.erorCode == 0)
        {
            self.isValid = YES;
            LXLog(@"RequestSuccess\npath=%@\nGet responseString:%@\n",self.path,self.dataDic);
            if (!FBIsEmpty([self.dataDic objectForKey:@"data"]))
            {
                if (!FBIsEmpty(self.dataDic)) {
                    self.isValid = YES;
                    [self.resultModel setModelFromValue:[self.dataDic objectForKey:@"data"]];
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
            
            //msg是个数组
            NSMutableArray *msgArr = (NSMutableArray *)[_dataDic objectForKey:@"msg"];
            self.erorMessage = msgArr[0];
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
