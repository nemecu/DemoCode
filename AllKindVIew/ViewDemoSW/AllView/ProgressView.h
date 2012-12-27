//
//  ProgressView.h
//  TestProgressView
//
//  Created by shaowei on 12-12-24.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic, retain) UIColor *bottomColor;//底色
@property (nonatomic, retain) UIColor *topColor;//顶色
@property (nonatomic, assign) CGFloat progressValue;//z值在0～1范围内有效
@property (nonatomic, assign) CGFloat height;//进度条的高度（与view的高度无关）

@property (nonatomic, assign) BOOL isRemoveFromSuperAfterToFull;//progress达到1后自动从superView删除，默认为yes；


@end
