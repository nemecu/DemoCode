//
//  GradientView.m
//  TestProgressView
//
//  Created by shaowei on 12-12-25.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor colorWithRed:0.856f green:0.856f blue:0.856f alpha:1.0f];
    CGFloat *startComponent = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    
    UIColor *centerColor = [UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.0f];
    CGFloat *centerComponent = (CGFloat *)CGColorGetComponents(centerColor.CGColor);
    
//    UIColor *endColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
//    CGFloat *endComponent = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    
    CGFloat component[12] =
    {
        startComponent[0],
        startComponent[1],
        startComponent[2],
        startComponent[3],
        
        centerComponent[0],
        centerComponent[1],
        centerComponent[2],
        centerComponent[3],
        
        startComponent[0],
        startComponent[1],
        startComponent[2],
        startComponent[3],
    };
    
    CGFloat location[3] = { 0.0f,0.5f,1.0f};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&component, (const CGFloat*)&location, 3);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawLinearGradient(context,
                                gradient,
                                CGPointMake(0, 0),
                                CGPointMake(0, rect.size.height),
                                kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
}


@end
