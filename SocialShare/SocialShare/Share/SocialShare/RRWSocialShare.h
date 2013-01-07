//
//  RRWSocialShare.h
//  DDIPhone
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define RRW_CONSUMER_KEY @"a763df8f3cbd484ab6b243bddaeeee8c"
#define RRW_CONSUMER_SECRET @"0302d7604d7942a5b9b12a0e7941eda6"
#define RRW_REDIRECT_URL @"http://www.renren.com"

#import <Foundation/Foundation.h>
#import "ISocialShare.h"
#import "Renren.h"

@interface RRWSocialShare : NSObject <ISocialShare, RenrenDelegate>{
    @private
    Renren *rrwEngine;
    id selfDelegate;
}

@end
