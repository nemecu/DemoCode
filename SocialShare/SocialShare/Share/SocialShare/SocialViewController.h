//
//  SocialViewController.h
//  SIP2iPhone
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 vin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISocialShare.h"

#define SYSTEM_VERSION_NUMBER [[UIDevice currentDevice].systemVersion floatValue]

typedef enum
{
    SocialOperationOfRepost = 1,
    SocialOperationOfComment = 2
}SocialOperationType;

@interface SocialViewController : UIViewController <UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIButton *shareButton;
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;
@property (retain, nonatomic) IBOutlet UILabel *numLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) NSString *systemContentText;
@property (retain, nonatomic) NSString *systemContentImage;
@property (retain, nonatomic) NSString *systemContentUrl;
@property (retain, nonatomic) NSString *userContentText;


- (void)setOperationType:(SocialOperationType)operationType;
- (void)setShareObject:(id<ISocialShare>)shareObject andID:(NSString *)wbid;
-(void)resetView;//重置View

- (IBAction)actionBack:(id)sender;
- (IBAction)actionShare:(id)sender;


@end
