//
//  SocialShareFactory.m
//  SIP2iPhone
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 vin. All rights reserved.
//

#import "SocialShareFactory.h"
#import "SMSShare.h"
#import "MailShare.h"
#import "TXSocialShare.h"
#import "SinaSocialShare.h"
#import "RRWSocialShare.h"

@interface SocialShareFactory()

@property (nonatomic, retain) id<IShare> mailShare;
@property (nonatomic, retain) id<IShare> smsShare;
@property (nonatomic, retain) id<ISocialShare> sinaSocialShare;
@property (nonatomic, retain) id<ISocialShare> txSocialShare;
@property (nonatomic, retain) id<ISocialShare> rrwSocialShare;

@end

@implementation SocialShareFactory

static SocialShareFactory *factoryInstance=nil;

+(id)getInstance{
    if (factoryInstance==nil) {
        factoryInstance=[[SocialShareFactory alloc] init];
    }
    return factoryInstance;
}

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(id<IShare>)getMailShare{
    if (!_mailShare) {
        MailShare *shareObj = [[MailShare alloc] init];
        self.mailShare = shareObj;
        [shareObj release];
    }
    return _mailShare;
}
-(id<IShare>)getSMSShare{
    if (!_smsShare) {
        SMSShare *shareObj = [[SMSShare alloc] init];
        self.smsShare = shareObj;
        [shareObj release];
    }
    return _smsShare;
}
-(id<ISocialShare>)getSinaSocialShare{
    if (!_sinaSocialShare) {
        SinaSocialShare *shareObj = [[SinaSocialShare alloc] init];
        self.sinaSocialShare = shareObj;
        [shareObj release];
    }
    return _sinaSocialShare;
}
-(id<ISocialShare>)getTXSocailShare{
    if (!_txSocialShare) {
        TXSocialShare *shareObj = [[TXSocialShare alloc] init];
        self.txSocialShare = shareObj;
        [shareObj release];
    }
    return _txSocialShare;
}
-(id<ISocialShare>)getRRWSocailShare{
    if (!_rrwSocialShare) {
        RRWSocialShare *shareObj = [[RRWSocialShare alloc] init];
        self.rrwSocialShare = shareObj;
        [shareObj release];
    }
    return _rrwSocialShare;
}

-(void)dealloc{
    [_mailShare release];
    [_smsShare release];
    [_sinaSocialShare release];
    [_txSocialShare release];
    [_rrwSocialShare release];
    [super dealloc];
}

@end
