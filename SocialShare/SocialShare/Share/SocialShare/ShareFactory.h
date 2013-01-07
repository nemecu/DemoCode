//
//  ShareFactory.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IShare.h"

@interface ShareFactory : NSObject{
    @private
    id<IShare> mailShare;
    id<IShare> smsShare;
    id<IShare> sinaSocialShare;
    id<IShare> txSocialShare;
    id<IShare> rrwSocialShare;
}

+(id)getInstance;
-(id<IShare>)getMailShare;
-(id<IShare>)getSMSShare;
-(id<IShare>)getSinaSocialShare;
-(id<IShare>)getTXSocailShare;
-(id<IShare>)getRRWSocailShare;
@end
