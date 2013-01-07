//
//  ShareFactory.m
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareFactory.h"

@implementation ShareFactory
static ShareFactory *instance=nil;

+(id)getInstance{
    if (instance==nil) {
        instance=[[ShareFactory alloc] init];
    }
    return instance;
}

-(id)init{
    if (self=[super init]) {
        //
        mailShare=nil;
        smsShare=nil;
        sinaSocialShare=nil;
        txSocialShare=nil;
        rrwSocialShare=nil;
    }
    return self;
}

-(id<IShare>)getMailShare{
    if (mailShare==nil) {
        Class mailShareClass=NSClassFromString(@"MailShare");
        mailShare=[[mailShareClass alloc] init];
    }
    return mailShare;
}
-(id<IShare>)getSMSShare{
    if (smsShare==nil) {
        Class smsShareClass=NSClassFromString(@"SMSShare");
        smsShare=[[smsShareClass alloc] init];
    }
    return smsShare;
}
-(id<IShare>)getSinaSocialShare{
    if (sinaSocialShare==nil) {
        Class sinaSocialShareClass=NSClassFromString(@"SinaSocialShare");
        sinaSocialShare=[[sinaSocialShareClass alloc] init];
    }
    return sinaSocialShare;
}
-(id<IShare>)getTXSocailShare{
    if (txSocialShare==nil) {
        Class txSocialShareClass=NSClassFromString(@"TXSocialShare");
        txSocialShare=[[txSocialShareClass alloc] init];
    }
    return txSocialShare;
}
-(id<IShare>)getRRWSocailShare{
    if (rrwSocialShare==nil) {
        Class rrwSocialShareClass=NSClassFromString(@"RRWSocialShare");
        rrwSocialShare=[[rrwSocialShareClass alloc] init];
    }
    return rrwSocialShare;
}

-(void)dealloc{
    if (mailShare!=nil) {
        [mailShare release];
    }
    if (smsShare!=nil) {
        [smsShare release];
    }
    if (sinaSocialShare!=nil) {
        [sinaSocialShare release];
    }
    if (txSocialShare!=nil) {
        [txSocialShare release];
    }
    if (rrwSocialShare!=nil) {
        [rrwSocialShare release];
    }
    [super dealloc];
}
@end
