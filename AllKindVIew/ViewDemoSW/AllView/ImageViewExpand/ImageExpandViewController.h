//
//  ImageExpandViewController.h
//  ViewDemoSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageExpandViewController : UIViewController

@property (retain, nonatomic) UIImageView *myImageView;
@property (retain, nonatomic) IBOutlet UIView *myTestView;


- (IBAction)actionIncrease:(id)sender;
- (IBAction)actionReduce:(id)sender;

@end
