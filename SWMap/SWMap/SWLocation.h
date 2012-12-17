//
//  SWLocation.h
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-11.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SWLocation : UIViewController<CLLocationManagerDelegate,UITextViewDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet UITextView *textShow;
@property (retain, nonatomic) IBOutlet UITextView *lableShow;



- (IBAction)actionStart:(id)sender;
- (IBAction)actionEnd:(id)sender;
- (IBAction)actionDiamiss:(id)sender;

- (IBAction)actionBackView:(id)sender;
- (void)LocationInit;
- (void)AvailableOfAll;
- (void)headingTest;
@end
