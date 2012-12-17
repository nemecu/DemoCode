//
//  pinchGesture.h
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-29.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pinchGesture : UIViewController<UIGestureRecognizerDelegate>{
    UIPinchGestureRecognizer *pinch;
    UIImageView *imageView;
}

@end
