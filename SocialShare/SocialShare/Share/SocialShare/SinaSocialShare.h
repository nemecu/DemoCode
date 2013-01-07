//
//  SinaSocialShare.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define SINA_CONSUMER_KEY @"3697899248"//@"458595199"
#define SINA_CONSUMER_SECRET @"4988c60127acb52bfb31a692f79537ea"//@"b9aca307a4365b2e15a9580e5a111cbe"
#define SINA_REDIRECT_URL @"http://www.sina.com"

#import <Foundation/Foundation.h>
#import "ISocialShare.h"
#import "WBEngine.h"

@interface SinaSocialShare : NSObject <ISocialShare, WBEngineDelegate>{
    @private
    WBEngine *sinaWeiboEngine;
    id selfDelegate;
}

@end
