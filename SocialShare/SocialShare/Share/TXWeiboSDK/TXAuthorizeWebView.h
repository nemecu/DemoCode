//
//  TXAuthorizeWebView.h
//  DDIPhone
//
//  Created by  on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 * 获取oauth2.0票据的key
 */
#define oauth2TokenKey @"access_token="
#define oauth2OpenidKey @"openid="
#define oauth2OpenkeyKey @"openkey="
#define oauth2ExpireInKey @"expire_in="

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> 
#import "OpenSdkBase.h"
#import "OpenSdkOauth.h"


@interface TXAuthorizeWebView : UIView <UIWebViewDelegate>
{
    UIView *panelView;
    UIView *containerView;
    UIActivityIndicatorView *indicatorView;
	UIWebView *webView;
    
    UIButton *closeButton;
    
    UIInterfaceOrientation previousOrientation;
    
    id delegate;
}

@property (nonatomic, assign) id delegate;

- (void)loadRequestWithURL:(NSURL *)url;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;
@end
