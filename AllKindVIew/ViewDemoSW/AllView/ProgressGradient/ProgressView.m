//
//  ProgressView.m
//  TestProgressView
//
//  Created by shaowei on 12-12-24.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()

@property (nonatomic, assign) CGGradientRef gradient;

@end

@implementation ProgressView

- (id)init
{
    self = [self initWithFrame:CGRectMake(0,
                                           0,
                                           [[UIScreen mainScreen] bounds].size.width,
                                           5.0f)];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //初始化默认值
        self.bottomColor = [UIColor redColor];
        self.topColor = [UIColor blueColor];
        self.progressValue = 0.2f;
        self.height = 5.0f;
        self.isRemoveFromSuperAfterToFull = NO;
        self.gradient = [self generateGradient];
        
    }
    return self;
}

- (void)dealloc
{
    CGGradientRelease(_gradient);
    [_bottomColor release];
    [_topColor release];
    [super dealloc];
}

#pragma mark Function

- (CGGradientRef )generateGradient{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    CGFloat *startComponent = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    
    UIColor *endColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
    CGFloat *endComponent = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    
    CGFloat component[8] =
    {
        startComponent[0],
        startComponent[1],
        startComponent[2],
        startComponent[3],
        
        endComponent[0],
        endComponent[1],
        endComponent[2],
        endComponent[3],
    };
    
    CGFloat location[2] = { 0.0f,0.5f};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&component, (const CGFloat*)&location, 2);
    
    CGColorSpaceRelease(colorSpace);
    
    return gradient;
}

- (void)endView{
    [self removeFromSuperview];
}

#pragma mark - action

- (void)setProgressValue:(CGFloat)progressValue{
    if (!(progressValue < 1.0f)) {
        progressValue = 1.0f;
        if (_isRemoveFromSuperAfterToFull) {
            [self endView];
        }
    }
    if (progressValue < 0.0f) {
        progressValue = 0.0f;
    }
    _progressValue = progressValue;
    [self setNeedsDisplay];
}

#pragma mark - 绘图

- (void)drawRect:(CGRect)rect{
    rect = CGRectMake(0, 0, rect.size.width, _height);
    CGPathRef pathOfBottom = CGPathCreateWithRect(rect, NULL);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, pathOfBottom);
    CGPathRelease(pathOfBottom);
    CGContextSetLineWidth(context, 3);
    
    [_bottomColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    if (_progressValue <1.0f) {
        rect.size.width *= _progressValue;
    }
    
    if (rect.size.width < 3.0f) {
        rect.size.width = 3.0f;
    }
    
    //画上层
    CGPathRef pathOfTop = CGPathCreateWithRect(rect, NULL);
    CGContextAddPath(context, pathOfTop);
    CGPathRelease(pathOfTop);
    
    [_topColor setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    //画渐变
    CGContextDrawRadialGradient(context,
                                _gradient,
                                CGPointMake(rect.size.width, _height*0.5f),
                                0,
                                CGPointMake(rect.size.width, _height*0.5f),
                                _height*5,
                                kCGGradientDrawsBeforeStartLocation);
    
    
    
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(ctx,1,0,0,1);//设置红色画笔
//    CGContextMoveToPoint(ctx,110,0);
//    CGContextAddLineToPoint(ctx,50,50);
//    CGContextAddLineToPoint(ctx,80,10);     //你可以去掉这一行和下面一行看看，就知道为什么我说的传入addArcToPoint方法里的参数本身不一定要绘制的原因了
//    CGContextAddLineToPoint(ctx,50,50);
//    
//    CGContextAddArcToPoint(ctx,80,10,80,110,50);
//    CGContextAddLineToPoint(ctx,80,110);    //测试显示调用addArcToPoint结束后current point不在(80,110)上，而是在弧线结束的地方
//    CGContextDrawPath(ctx, kCGPathStroke) ;
//}


@end
