//
//  RRWSocialShare.m
//  DDIPhone
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RRWSocialShare.h"

@implementation RRWSocialShare

- (id)init
{
    self = [super init];
    if (self) {
        rrwEngine = [[Renren alloc] init];
        [rrwEngine isSessionValid];
        rrwEngine.appKey = RRW_CONSUMER_KEY;
        rrwEngine.appId = RRW_CONSUMER_SECRET;
    }
    return self;
}

-(void)send:(NSDictionary *)content delegate:(id)delegate{
    NSString *body=[content objectForKey:@"body"];
    NSString *path=[content objectForKey:@"path"];
    UIImage *image=[UIImage imageWithContentsOfFile:path];
    
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (image){
            [params setValue:body forKey:@"caption"];
            [params setValue:path forKey:@"upload"];
            [params setValue:@"photos.upload" forKey:@"method"];
            [rrwEngine requestWithParams:params andDelegate:self];
        }else{
            [params setValue:body forKey:@"title"];
            [params setValue:body forKey:@"content"];
            [params setValue:@"blog.addBlog" forKey:@"method"];
            [rrwEngine requestWithParams:params andDelegate:self];
        }
    }else {
        NSLog(@"RenRen NotAuthorized...");
        [self login:delegate];
    }
}

-(void)login:(id)delegate{
    if (!rrwEngine) {
        rrwEngine = [[Renren alloc] init];
        [rrwEngine isSessionValid];
        rrwEngine.appKey = RRW_CONSUMER_KEY;
        rrwEngine.appId = RRW_CONSUMER_SECRET;
    }
    if (![rrwEngine isSessionValid]) {
        selfDelegate=delegate;
        NSArray *permissions=[NSArray arrayWithObjects:@"photo_upload",@"publish_feed",@"publish_share",@"publish_blog",nil];
        [rrwEngine authorizationWithPermisson:permissions andDelegate:self];
    }else {
        //直接登录
        
    }
}

-(void)logout:(id)delegate{
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
         [rrwEngine logout:self];
    }
}

//以下两个方法在人人中是不能使用的，原因人人不能转发和评论某一条微博
-(void)repost:(NSDictionary *)content delegate:(id)delegate{
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:wbid forKey:@"title"];
        [params setValue:body forKey:@"content"];
        [params setValue:@"blog.addBlog" forKey:@"method"];
        [rrwEngine requestWithParams:params andDelegate:self];
    }else {
        NSLog(@"RenRen NotAuthorized...");
        [self login:delegate];
    }
}

-(void)comment:(NSDictionary *)content delegate:(id)delegate{
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:wbid forKey:@"title"];
        [params setValue:body forKey:@"content"];
        [params setValue:@"blog.addBlog" forKey:@"method"];
        [rrwEngine requestWithParams:params andDelegate:self];
    }else {
        NSLog(@"RenRen NotAuthorized...");
        [self login:delegate];
    }
}
//结束

-(void)userInfo:(id)delegate{
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"users.getInfo" forKey:@"method"];
        [rrwEngine requestWithParams:params andDelegate:self];
    }else {
        NSLog(@"RenRen NotAuthorized...");
        [self login:delegate];
    }
}

-(void)userState:(id)delegate{
    if (rrwEngine!=nil&&[rrwEngine isSessionValid]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RRWUserState"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RRWUserState"];
    }
}


/**
 * 接口请求成功，第三方开发者实现这个方法
 * @param renren 传回代理服务器接口请求的Renren类型对象。
 * @param response 传回接口请求的响应。
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response{
    NSLog(@"RenRen RequestSuccess...");
    id result=response.rootObject;
    NSDictionary *resultDict=nil;
    if ([result isKindOfClass:[NSArray class]]) {
        resultDict=[result objectAtIndex:0];
    }else if ([result isKindOfClass:[NSDictionary class]]) {
        resultDict=result;
    }
    if (!resultDict) {
        return;
    }
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

/**
 * 接口请求失败，第三方开发者实现这个方法
 * @param renren 传回代理服务器接口请求的Renren类型对象。
 * @param response 传回接口请求的错误对象。
 */
- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error{
    NSLog(@"RenRen RequestFail...");
}

/**
 * renren取消Dialog时调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renrenDialogDidCancel:(Renren *)renren{
    NSLog(@"RenRen DialogDidCancel...");
}
/**
 * 授权登录成功时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renrenDidLogin:(Renren *)renren{
    NSLog(@"RenRen LoginSuccess...");
    //[self userInfo:selfDelegate];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RRWUserState"];
}

/**
 * 用户登出成功后被调用 第三方开发者实现这个方法
 * @param renren 传回代理登出接口请求的Renren类型对象。
 */
- (void)renrenDidLogout:(Renren *)renren{
    NSLog(@"RenRen LoginoutSuccess...");
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RRWUserState"];
}

/**
 * 授权登录失败时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error{
    NSLog(@"RenRen LoginFail...");
}
@end
