//
//  LZBMKAnnotationViewProtocol.h
//  BaiduMapSW
//
//  Created by shaowei on 13-1-5.
//  Copyright (c) 2013年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@protocol LZBMKAnnotationViewProtocol <NSObject>

@property (nonatomic, retain) id<BMKAnnotation> infoDict;

- (void)showFromRect:(CGRect)rect;
- (void)actionLeftBtnClick:(id)sender;
- (void)actionRightBtnClick:(id)sender;

@end
