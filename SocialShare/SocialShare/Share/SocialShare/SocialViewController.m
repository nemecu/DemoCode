//
//  SocialViewController.m
//  SIP2iPhone
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 vin. All rights reserved.
//

#import "SocialViewController.h"

#define FROM_APPNAME @"来自苏州工业园区App"
#define FROM_APPURL @"http://itunes.apple.com/us/app/ding-dong/id564155555?mt=8"
#define WEIBO_MAX_LENGTH 140
#define WEIBO_SHORT_URL_LENGTH 10

#define SEND_CONTENT_FORMAT @"%@-%@%@ %@:%@"

@interface SocialViewController ()

@property (nonatomic, copy) NSString *wbid;
@property (nonatomic, assign) SocialOperationType operationType;
@property (nonatomic, retain) id<ISocialShare>shareObject;

@property (nonatomic, assign) NSInteger contentLength;

@property (nonatomic, copy) NSString *naviTitle;


@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _contentLength = 0;
    
    [self resetView];
    
    self.titleLabel.text = _naviTitle;
}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setShareButton:nil];
    [self setContentTextView:nil];
    [self setNumLabel:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_naviTitle release];
    [_wbid release];
    [_shareObject release];
    [_backButton release];
    [_shareButton release];
    [_contentTextView release];
    [_systemContentText release];
    [_systemContentImage release];
    [_systemContentUrl release];
    [_userContentText release];
    [_titleLabel release];
    [super dealloc];
}

#pragma mark - 变量值Set方法 自定义

- (void)setOperationType:(SocialOperationType)operationType{
    _operationType = operationType;
    switch (operationType) {
        case SocialOperationOfComment:
        {
            [self commentUI];
        }
            break;
        case SocialOperationOfRepost:
        {
            [self repostUI];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Custom Function

- (void)setShareObject:(id<ISocialShare>)shareObject andID:(NSString *)wbid{
    self.shareObject = shareObject;
    self.wbid = wbid;
}

- (void)repostUI{
    self.titleLabel.text = @"转发";
    self.naviTitle = @"转发";
}

- (void)commentUI{
    self.titleLabel.text = @"评论";
    self.naviTitle = @"评论";
}

//重置View
-(void)resetView{

    [_contentTextView setText:@""];
    [_contentTextView setDelegate:self];
    [_contentTextView becomeFirstResponder];
    
    _contentLength = 0;
    _contentLength += [_systemContentText length];
    _contentLength += [FROM_APPNAME length];
    
    if ([_systemContentUrl length]) {
        _contentLength += WEIBO_SHORT_URL_LENGTH;
    }
    
    if ([FROM_APPURL length]) {
        _contentLength += WEIBO_SHORT_URL_LENGTH;
    }
    
    [_numLabel setText:[NSString stringWithFormat:@"%d字",WEIBO_MAX_LENGTH-_contentLength]];
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    int count=[[_contentTextView text] length];
    if (WEIBO_MAX_LENGTH-_contentLength-count<=0) {
        [_contentTextView setText:[[_contentTextView text] substringToIndex:WEIBO_MAX_LENGTH-_contentLength]];
        [_numLabel setText:[NSString stringWithFormat:@"%d字",0]];
        return;
    }
    [_numLabel setText:[NSString stringWithFormat:@"%d字",WEIBO_MAX_LENGTH-_contentLength-count]];
}


#pragma mark - action

- (IBAction)actionBack:(id)sender {
    if (SYSTEM_VERSION_NUMBER < 5.0f) {
        [self dismissModalViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

}

- (IBAction)actionShare:(id)sender {
    
    if (!_contentTextView.text.length) {
        return;
    }
    
    NSAssert(_wbid, @"缺少参数 wbid");
    NSAssert(_operationType, @"缺少参数 operationType");
    NSAssert(_shareObject, @"缺少参数 _shareObject");
    
    self.userContentText=_contentTextView.text;
    NSString *sendContentText=[NSString stringWithFormat:SEND_CONTENT_FORMAT,
                               _userContentText,
                               _systemContentText?_systemContentText:@"",
                               _systemContentUrl?_systemContentUrl:@"",
                               FROM_APPNAME,
                               FROM_APPURL];
    NSDictionary *paramDict=[NSDictionary dictionaryWithObjectsAndKeys:
                             _wbid,@"wbid",
                             sendContentText,@"body", nil];
    
    switch (_operationType) {
        case SocialOperationOfRepost:
        {
            [_shareObject repost:paramDict delegate:self];
        }
            break;
        case SocialOperationOfComment:
        {
            [_shareObject comment:paramDict delegate:self];
        }
            break;
            
        default:
            NSAssert1(0, @"_operationType参数错误 %d",_operationType);
            break;
    }
    [self actionBack:nil];
}

@end
