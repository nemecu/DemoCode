//
//  SWAnnotation.m
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-6.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWAnnotation.h"

@implementation SWAnnotation

@synthesize latitude;
@synthesize longitude;
@synthesize tag;
@synthesize type;

- (CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D location;
    location.latitude = self.latitude;
    location.longitude = self.longitude;
//    NSLog(@"(CLLocationCoordinate2D)coordinate\n");
    
    return location;
    
}

// Title and subtitle for use by selection UI.
- (NSString *)title
{
    return @"SW- title";
}


- (NSString *)subtitle
{
    return @"SW- subtitle";
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    self.longitude = newCoordinate.longitude;
    self.latitude = newCoordinate.latitude;
    
//    self.coordinate = newCoordinate;
    
    NSLog(@"setCoordinate\n");
}



- (void)dealloc{
    
    
    
    
    [super dealloc];
}

@end
