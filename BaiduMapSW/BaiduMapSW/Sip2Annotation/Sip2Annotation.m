//
//  Sip2Annotation.m
//  BaiduMapSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "Sip2Annotation.h"

@interface Sip2Annotation()

@property (nonatomic, retain) UIButton *leftBtn;
//@property (nonatomic, assign) 

@end

@implementation Sip2Annotation

- (void)dealloc
{
    [_leftBtn release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addButton];
    }
    return self;
}

- (void)addButton{
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [_leftBtn setImage:[UIImage imageNamed:@"p_big"] forState:UIControlStateNormal];
    [self addSubview:_leftBtn];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
