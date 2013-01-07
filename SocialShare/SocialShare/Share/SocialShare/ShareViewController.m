//
//  ShareViewController.m
//  DDIPhone
//
//  Created by  on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define SHARESINA 1
#define SHARETX 2
#define SHARERRW 3

#define FROMAPPNAME @"来自苏州工业园区App"
#define FROMAPPURL @"http://itunes.apple.com/us/app/ding-dong/id564155555?mt=8"

#define SENDCONTENTFORMAT @"%@-%@%@ %@:%@"

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize backButton;
@synthesize shareButton;
@synthesize contentTextView;
@synthesize numLabel;

@synthesize systemContentText;
@synthesize systemContentImage;
@synthesize systemContentUrl;

@synthesize userContentText;

@synthesize shareFlag;
int initLength=0;

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
    if ([self respondsToSelector:@selector(initView)]) {
        [self performSelector:@selector(initView)];
    }else {
        //
    }
    
}

- (void)viewDidUnload
{
    [self setBackButton:nil];
    [self setShareButton:nil];
    [self setContentTextView:nil];
    [self setNumLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)initView{
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [contentTextView setText:@""];
    [contentTextView setDelegate:self];
    [contentTextView becomeFirstResponder];
    initLength=0;
    if((systemContentText!=nil&&[systemContentText length]!=0)||(systemContentUrl!=nil&&[systemContentUrl length]!=0)){
        initLength=[systemContentText length];
        if ((systemContentUrl!=nil&&[systemContentUrl length]!=0)) {
            initLength+=10;
        }
        initLength+=[FROMAPPNAME length];
        if ([FROMAPPURL length]!=0) {
            initLength+=10;
        }
        [numLabel setText:[NSString stringWithFormat:@"%d字",140-initLength]];
    }else {
        [numLabel setText:[NSString stringWithFormat:@"%d字",140]];
    }

}

-(void)backButtonClicked:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)shareButtonClicked:(UIButton *)button{
    if (userContentText==nil) {
        userContentText=@"";
    }
    if (systemContentText==nil) {
        systemContentText=@"";
    }
    if (systemContentUrl==nil) {
        systemContentUrl=@"";
    }
    if (systemContentImage==nil) {
        systemContentImage=@"";
    }
    userContentText=contentTextView.text;
    NSString *sendContentText=[NSString stringWithFormat:SENDCONTENTFORMAT,userContentText,systemContentText,systemContentUrl,FROMAPPNAME,FROMAPPURL];
    if (shareFlag==SHARESINA) {
        id sinaSocialShare=[[ShareFactory getInstance] getSinaSocialShare];
        NSDictionary *paramDict=[NSDictionary dictionaryWithObjectsAndKeys:sendContentText,@"body",systemContentImage,@"path", nil];
        [sinaSocialShare send:paramDict delegate:self];
    }
    if (shareFlag==SHARETX) {
        id txSocialShare=[[ShareFactory getInstance] getTXSocailShare];
        NSDictionary *paramDict=[NSDictionary dictionaryWithObjectsAndKeys:sendContentText,@"body",systemContentImage,@"path", nil];
        [txSocialShare send:paramDict delegate:self];
    }
    if (shareFlag==SHARERRW) {
        id rrwSocialShare=[[ShareFactory getInstance] getRRWSocailShare];
        NSDictionary *paramDict=[NSDictionary dictionaryWithObjectsAndKeys:sendContentText,@"body",systemContentImage,@"path", nil];
        [rrwSocialShare send:paramDict delegate:self];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    int count=[[contentTextView text] length];
    if (140-initLength-count<=0) {
        [contentTextView setText:[[contentTextView text] substringToIndex:140-initLength]];
        [numLabel setText:[NSString stringWithFormat:@"%d字",0]];
        return;
    }
    [numLabel setText:[NSString stringWithFormat:@"%d字",140-initLength-count]];
}

- (void)dealloc {
    [backButton release];
    [shareButton release];
    [contentTextView release];
    [numLabel release];
    [super dealloc];
}
@end
