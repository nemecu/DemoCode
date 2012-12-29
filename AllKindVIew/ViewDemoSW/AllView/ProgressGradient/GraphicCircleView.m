//
//  GraphicCircleView.m
//  ViewDemoSW
//
//  Created by shaowei on 12-12-28.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "GraphicCircleView.h"

@implementation GraphicCircleView

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
    CGContextAddArc(context,
                    rect.size.width*0.5f,
                    rect.size.height*0.5f,
                    60,
                    M_PI_4, M_PI, 1);
    [[UIColor whiteColor] setFill];
    CGContextFillPath(context);
}


@end
