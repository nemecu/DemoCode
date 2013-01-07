//
//  TXSocialShare.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/*
 App Key:801295062
 App Secret:20adeedd2932a7c2cacd3f86fb2e9a06
 */
#define TX_CONSUMER_KEY @"801295062"//@"801230309"//@"801128501"
#define TX_CONSUMER_SECRET @"20adeedd2932a7c2cacd3f86fb2e9a06"//@"57afa3f5a043dfab70c4bfe5b2b10821"//@"f95486443cdebd1789e51e4bacad9984"
#define TX_REDIRECT_URL @"http://www.vi-in.com"//@"http://dingdong580.com"//@"http://www.qq.com"

#define TXBASEURL @"https://open.t.qq.com/api/"

#import <Foundation/Foundation.h>
#import "ISocialShare.h"
@class OpenSdkOauth;
#import "OpenSdkRequest.h"
//#import "LZDataCommon.h"

@interface TXSocialShare : NSObject <ISocialShare>{
    @private
    OpenSdkOauth *txWeiboEngine;
}
@property (assign)id selfDelegate;

@end
