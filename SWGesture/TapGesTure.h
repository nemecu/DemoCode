//
//  TapGesTure.h
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-28.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapGesTure : UIViewController<UIGestureRecognizerDelegate>{
    UIPinchGestureRecognizer * pinGesture;
    UISwipeGestureRecognizer * swipeGesture;
    UIRotationGestureRecognizer * rotationGesture;
    UIPanGestureRecognizer * panGesture;
    UILongPressGestureRecognizer * lonGesture;
    UIImageView *imageView;
}


@property (retain, nonatomic) IBOutlet UITapGestureRecognizer *tapGestrue;


- (IBAction)actionTap:(id)sender;

@end
