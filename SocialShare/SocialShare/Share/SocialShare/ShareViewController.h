//
//  ShareViewController.h
//  DDIPhone
//
//  Created by  on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareFactory.h"

@interface ShareViewController : UIViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIButton *shareButton;
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;
@property (retain, nonatomic) IBOutlet UILabel *numLabel;

@property (retain, nonatomic) NSString *systemContentText;
@property (retain, nonatomic) NSString *systemContentImage;
@property (retain, nonatomic) NSString *systemContentUrl;
@property (retain, nonatomic) NSString *userContentText;

@property (assign) int shareFlag;

@end
