//
//  SWtouch.h
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-28.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWtouch : UIViewController<UIGestureRecognizerDelegate>{
    BOOL isfangfa;
}



@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain) UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btn;

@property CGRect imageRect;
- (IBAction)actionss:(id)sender;

@end
