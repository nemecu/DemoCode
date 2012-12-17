//
//  swAnnotation.h
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-6.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SWAnnotation : NSObject <MKAnnotation>{
    
}

@property (assign) float latitude;
@property (assign) float longitude;
@property (assign) int tag;

@property (assign, nonatomic) int type;



@end
