//
//  ISocialShare.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IShare.h"

@protocol ISocialShare <IShare>
@required
-(void)login:(id)delegate;
@required
-(void)logout:(id)delegate;
@required
-(void)repost:(NSDictionary *)content delegate:(id)delegate;
@required
-(void)comment:(NSDictionary *)content delegate:(id)delegate;
@required
-(void)userInfo:(id)delegate;
@required
-(void)userState:(id)delegate;
@end
