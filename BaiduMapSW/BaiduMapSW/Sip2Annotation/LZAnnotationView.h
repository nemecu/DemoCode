//
//  LZAnnotationView.h
//  BaiduMapSW
//
//  Created by shaowei on 13-1-5.
//  Copyright (c) 2013年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBMKAnnotationViewProtocol.h"


@interface LZAnnotationView : UIView<LZBMKAnnotationViewProtocol>

@property (nonatomic, retain) id<BMKAnnotation> infoDict;

@end
