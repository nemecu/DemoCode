//
//  AnnotationView.h
//  BaiduMapSW
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnotationView : UIView


- (void)setFlagImage:(UIImage *)image;
- (void)resetStatus;
- (void)setImageName:(NSString *)imageName andTitle:(NSString *)title;
- (void)setShow:(BOOL)isShow;

- (void)setAnnotationViewPoint:(CGPoint)location;

@end
