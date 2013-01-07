//
//  SinaSocialShare.m
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SinaSocialShare.h"

@implementation SinaSocialShare

- (id)init
{
    self = [super init];
    if (self) {
        sinaWeiboEngine=[[WBEngine alloc] initWithAppKey:SINA_CONSUMER_KEY appSecret:SINA_CONSUMER_SECRET];
        sinaWeiboEngine.delegate = self;
    }
    return self;
}

-(void)send:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *body=[content objectForKey:@"body"];
    NSString *path=[content objectForKey:@"path"];
    UIImage *image=[UIImage imageWithContentsOfFile:path];
    
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params setObject:(body ? body : @"") forKey:@"status"];
        if (image){
            [params setObject:image forKey:@"pic"];
            [sinaWeiboEngine loadRequestWithMethodName:@"statuses/upload.json"
                                            httpMethod:@"POST"
                                                params:params
                                          postDataType:kWBRequestPostDataTypeMultipart
                                      httpHeaderFields:nil];
        }else{
            [sinaWeiboEngine loadRequestWithMethodName:@"statuses/update.json"
                                            httpMethod:@"POST"
                                                params:params
                                          postDataType:kWBRequestPostDataTypeNormal
                                      httpHeaderFields:nil];
        }
    }else {
        NSLog(@"Sina NotAuthorized...");
        [self login:delegate];
    }
}

-(void)login:(id)delegate{
    selfDelegate=delegate;
    if (sinaWeiboEngine==nil) {
        sinaWeiboEngine=[[WBEngine alloc] initWithAppKey:SINA_CONSUMER_KEY appSecret:SINA_CONSUMER_SECRET];
    }
    if (![sinaWeiboEngine isLoggedIn]||[sinaWeiboEngine isAuthorizeExpired]) {
        [sinaWeiboEngine setRootViewController:delegate];
        [sinaWeiboEngine setRedirectURI:SINA_REDIRECT_URL];
        [sinaWeiboEngine setIsUserExclusive:NO];
        [sinaWeiboEngine setDelegate:self];
        [sinaWeiboEngine logIn];
    }else {
        //直接登录
    }
    
}

-(void)logout:(id)delegate{
    selfDelegate=delegate;
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        [sinaWeiboEngine logOut];
    }
}

-(void)repost:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    
    
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params setObject:(wbid ? wbid : @"") forKey:@"id"];
        [params setObject:(body ? body : @"") forKey:@"status"];
        [sinaWeiboEngine loadRequestWithMethodName:@"statuses/repost.json"
                                        httpMethod:@"POST"
                                            params:params
                                      postDataType:kWBRequestPostDataTypeNormal
                                  httpHeaderFields:nil];
    }else {
        NSLog(@"Sina NotAuthorized...");
        [self login:delegate];
    }
}

-(void)comment:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params setObject:(wbid ? wbid : @"") forKey:@"id"];
        [params setObject:(body ? body : @"") forKey:@"comment"];
        [sinaWeiboEngine loadRequestWithMethodName:@"comments/create.json"
                                        httpMethod:@"POST"
                                            params:params
                                      postDataType:kWBRequestPostDataTypeNormal
                                  httpHeaderFields:nil];
    }else {
        NSLog(@"Sina NotAuthorized...");
        [self login:delegate];
    }
}

-(void)userInfo:(id)delegate{
    selfDelegate=delegate;
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        [params setObject:@"" forKey:@"source"];
        [params setObject:sinaWeiboEngine.accessToken forKey:@"access_token"];
        [sinaWeiboEngine loadRequestWithMethodName:@"account/get_uid.json"
                                        httpMethod:@"GET"
                                            params:params
                                      postDataType:kWBRequestPostDataTypeNormal
                                  httpHeaderFields:nil];
    }else {
        NSLog(@"Sina NotAuthorized...");
        [self login:delegate];
    }
}

-(void)userState:(id)delegate{
    if (sinaWeiboEngine!=nil&&[sinaWeiboEngine isLoggedIn]&&![sinaWeiboEngine isAuthorizeExpired]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SINAUserState"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SINAUserState"];
    }
}

/////回调方法
- (void)engineAlreadyLoggedIn:(WBEngine *)engine{
    NSLog(@"Sina AlreadyLoggedIn...");
}

- (void)engineDidLogIn:(WBEngine *)engine{
    NSLog(@"Sina SuccessToLogIn....");
    //[self userInfo:selfDelegate];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SINAUserState"];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error{
    NSLog(@"Sina FailToLogIn...");
}

- (void)engineDidLogOut:(WBEngine *)engine{
    NSLog(@"Sina SuccessToLogOut...");
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SINAUserState"];
}

- (void)engineNotAuthorized:(WBEngine *)engine{
    NSLog(@"Sina NotAuthorized...");
}

- (void)engineAuthorizeExpired:(WBEngine *)engine{
    NSLog(@"Sina AuthorizeExpired...");
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    NSLog(@"Sina FailToRequest...");
}

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
    NSLog(@"Sina SuccessToRequest...");
    NSLog(@"%@",result);
    NSDictionary *resultDict=result;
    NSString *uidStr=[NSString  stringWithFormat:@"%@",[((NSDecimalNumber *)[resultDict objectForKey:@"uid"]) description]];
    if (uidStr&&![uidStr isEqualToString:@"(null)"]) {
        NSLog(@"%@",uidStr);
        //写入本地文件
    }else {
        //提示分享成功
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"分享成功" message:@"恭喜您分享内容成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}
@end
