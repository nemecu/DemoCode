//
//  TXSocialShare.m
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TXSocialShare.h"

@implementation TXSocialShare
@synthesize selfDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        txWeiboEngine = [[OpenSdkOauth alloc] initAppKey:TX_CONSUMER_KEY appSecret:TX_CONSUMER_SECRET];
    }
    return self;
}

-(void)send:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *body=[content objectForKey:@"body"];
    NSString *path=[content objectForKey:@"path"];
    UIImage *image=[UIImage imageWithContentsOfFile:path];
    
    if (txWeiboEngine!=nil&&[txWeiboEngine isLoggedIn]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"ios-sdk1.2" forKey:@"appfrom"];
        NSString *SeqId = [NSString stringWithFormat:@"%u", arc4random() % 9999999 + 123456];
        [params setObject:SeqId forKey:@"seqid"];
        [params setObject:@"127.0.0.1" forKey:@"clientip"];
        
        [params setObject:body forKey:@"content"];
        [params setObject:@"json"  forKey:@"format"];
        [params setObject:@"31.31299840379997" forKey:@"wei"];
        [params setObject:@"120.7272225379944" forKey:@"jing"];
        [params setObject:@"0" forKey:@"syncflag"];
        
        if (image){
            OpenSdkRequest *request=[[OpenSdkRequest alloc] init];
            NSString *requestUrl = [NSString stringWithFormat:@"%@%@",TXBASEURL,@"t/add_pic"];
            NSMutableDictionary *files = [NSMutableDictionary dictionary];
            [files setObject:path forKey:@"pic"];
            uint16_t retCode;
            NSString *resultStr = [request sendApiRequest:requestUrl httpMethod:@"POST" oauth:txWeiboEngine params:params files:files oauthType:txWeiboEngine.oauthType retCode:&retCode];
            
            if (resultStr == nil) {
                [OpenSdkBase showMessageBox:@"您没有授权或授权失败"];
                return;
            }
            if (retCode == resSuccessed) {
                [OpenSdkBase showMessageBox:@"恭喜您分享内容成功"]; 
            } else {
                [OpenSdkBase showMessageBox:@"您分享内容失败,请重新分享"];
            }
            
        }else{
            NSString *requestUrl = [NSString stringWithFormat:@"%@%@",TXBASEURL,@"t/add"];
            OpenSdkRequest *request=[[OpenSdkRequest alloc] init];
            uint16_t retCode;
            NSString *resultStr = [request sendApiRequest:requestUrl httpMethod:@"POST" oauth:txWeiboEngine params:params files:nil oauthType:txWeiboEngine.oauthType retCode:&retCode];
            
            if (resultStr == nil) {
                [OpenSdkBase showMessageBox:@"您没有授权或授权失败"];
                return;
            }
            if (retCode == resSuccessed) {
                [OpenSdkBase showMessageBox:@"恭喜您分享内容成功"]; 
            } else {
                [OpenSdkBase showMessageBox:@"您分享内容失败,请重新分享"];
            }
        }
    }else {
        NSLog(@"TX NotAuthorized...");
        [self login:delegate];
    }
}

-(void)login:(id)delegate{
    selfDelegate=delegate;
    if (txWeiboEngine==nil) {
        txWeiboEngine = [[OpenSdkOauth alloc] initAppKey:TX_CONSUMER_KEY appSecret:TX_CONSUMER_SECRET];
        [txWeiboEngine setRedirectURI:TX_REDIRECT_URL];
    }
    if (![txWeiboEngine isLoggedIn]) {
        [txWeiboEngine doWebViewAuthorizeWithDelegate:self];
    }else {
        //直接登录
    }
}

-(void)logout:(id)delegate{
    selfDelegate=delegate;
    if ([txWeiboEngine isLoggedIn]) {
        [txWeiboEngine logOut];
    }
}

-(void)repost:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    if (txWeiboEngine!=nil&&[txWeiboEngine isLoggedIn]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"ios-sdk1.2" forKey:@"appfrom"];
        NSString *SeqId = [NSString stringWithFormat:@"%u", arc4random() % 9999999 + 123456];
        [params setObject:SeqId forKey:@"seqid"];
        [params setObject:@"127.0.0.1" forKey:@"clientip"];
        
        [params setObject:body forKey:@"content"];
        [params setObject:wbid forKey:@"reid"];
        [params setObject:@"json"  forKey:@"format"];
        [params setObject:@"31.31299840379997" forKey:@"wei"];
        [params setObject:@"120.7272225379944" forKey:@"jing"];
        [params setObject:@"0" forKey:@"syncflag"];
        
        NSString *requestUrl = [NSString stringWithFormat:@"%@%@",TXBASEURL,@"t/re_add"];
        OpenSdkRequest *request=[[OpenSdkRequest alloc] init];
        uint16_t retCode;
        NSString *resultStr = [request sendApiRequest:requestUrl httpMethod:@"POST" oauth:txWeiboEngine params:params files:nil oauthType:txWeiboEngine.oauthType retCode:&retCode];
        
        if (resultStr == nil) {
            [OpenSdkBase showMessageBox:@"没有授权或授权失败"];
            return;
        }
        if (retCode == resSuccessed) {
            [OpenSdkBase showMessageBox:@"恭喜您转发内容成功"]; 
        } else {
            [OpenSdkBase showMessageBox:@"您转发内容失败,请重新转发"];
        }
    }else {
        NSLog(@"TX NotAuthorized...");
        [self login:delegate];
    }
}

-(void)comment:(NSDictionary *)content delegate:(id)delegate{
    selfDelegate=delegate;
    NSString *wbid=[content objectForKey:@"wbid"];
    NSString *body=[content objectForKey:@"body"];
    
    if (txWeiboEngine!=nil&&[txWeiboEngine isLoggedIn]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"ios-sdk1.2" forKey:@"appfrom"];
        NSString *SeqId = [NSString stringWithFormat:@"%u", arc4random() % 9999999 + 123456];
        [params setObject:SeqId forKey:@"seqid"];
        [params setObject:@"127.0.0.1" forKey:@"clientip"];
        
        [params setObject:body forKey:@"content"];
        [params setObject:wbid forKey:@"reid"];
        [params setObject:@"json"  forKey:@"format"];
        [params setObject:@"31.31299840379997" forKey:@"wei"];
        [params setObject:@"120.7272225379944" forKey:@"jing"];
        [params setObject:@"0" forKey:@"syncflag"];
        
        NSString *requestUrl = [NSString stringWithFormat:@"%@%@",TXBASEURL,@"t/comment"];
        OpenSdkRequest *request=[[OpenSdkRequest alloc] init];
        uint16_t retCode;
        NSString *resultStr = [request sendApiRequest:requestUrl httpMethod:@"POST" oauth:txWeiboEngine params:params files:nil oauthType:txWeiboEngine.oauthType retCode:&retCode];
        
        if (resultStr == nil) {
            [OpenSdkBase showMessageBox:@"没有授权或授权失败"];
            return;
        }
        if (retCode == resSuccessed) {
            [OpenSdkBase showMessageBox:@"恭喜您评论成功"]; 
        } else {
            [OpenSdkBase showMessageBox:@"您评论失败,请重新评论"];
        }
    }else {
        NSLog(@"TX NotAuthorized...");
        [self login:delegate];
    }
}

-(void)userInfo:(id)delegate{
    selfDelegate=delegate;
    if (txWeiboEngine!=nil&&[txWeiboEngine isLoggedIn]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"127.0.0.1" forKey:@"clientip"];
        [params setObject:txWeiboEngine.openid forKey:@"openid"];
        [params setObject:@"2.a" forKey:@"oauth_version"];
        [params setObject:@"all"  forKey:@"scope"];
        
        NSString *requestUrl = [NSString stringWithFormat:@"%@%@",TXBASEURL,@"user/info"];
        OpenSdkRequest *request=[[OpenSdkRequest alloc] init];
        uint16_t retCode;
        NSString *resultStr = [request sendApiRequest:requestUrl httpMethod:@"POST" oauth:txWeiboEngine params:params files:nil oauthType:txWeiboEngine.oauthType retCode:&retCode];
        
        if (resultStr == nil) {
            [OpenSdkBase showMessageBox:@"没有授权或授权失败"];
            return;
        }
        if (retCode == resSuccessed) {
            //[OpenSdkBase showMessageBox:resultStr];
            NSLog(@"%@",resultStr);
            NSDictionary *resultDict=[resultStr objectFromJSONString];
            NSDictionary *dataDict=((NSDictionary *)[resultDict objectForKey:@"data"]);
            NSString *uidStr=[NSString  stringWithFormat:@"%@",[((NSDecimalNumber *)[dataDict objectForKey:@"openid"]) description]];
            if (uidStr&&![uidStr isEqualToString:@"(null)"]) {
                NSLog(@"%@",uidStr);
                //写入本地文件
            }else {
                //提示分享成功
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"分享成功" message:@"恭喜您分享内容成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [alertView release];
            }
        } else {
            [OpenSdkBase showMessageBox:@"获取您的信息失败,请检查您的账号或密码是否正确,然后重新登录"];
        }
    }else {
        NSLog(@"TX NotAuthorized...");
        [self login:delegate];
    }
}

-(void)userState:(id)delegate{
    if (txWeiboEngine!=nil&&[txWeiboEngine isLoggedIn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TXUserState"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TXUserState"];
    }
}

@end
