//
//  IShare.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IShare <NSObject>
@required
-(void)send:(NSDictionary *)content delegate:(id)delegate;
@end
