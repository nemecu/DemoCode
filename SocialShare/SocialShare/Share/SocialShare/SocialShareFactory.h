//
//  SocialShareFactory.h
//  SIP2iPhone
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 vin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISocialShare.h"

@interface SocialShareFactory : NSObject{
    
}

+(id)getInstance;
-(id<IShare>)getMailShare;
-(id<IShare>)getSMSShare;
-(id<ISocialShare>)getSinaSocialShare;
-(id<ISocialShare>)getTXSocailShare;
-(id<ISocialShare>)getRRWSocailShare;

@end
