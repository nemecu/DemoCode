//
//  AnnotationViewSW.m
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-4-1.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "AnnotationViewSW.h"

@implementation AnnotationViewSW

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)imageOfCreat{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
    [imageView setAnimationDuration:0.5];
    [imageView setAnimationRepeatCount:-1];
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:4];
    for ( int i = 0; i<4; i++) {
        UIImage *tmp = [UIImage imageNamed:[NSString stringWithFormat:@"HomePage_%d",i]];
        [mArr addObject:tmp];
    }
    [imageView setAnimationImages:mArr];
    [mArr release];
    [self addSubview:imageView];
    [imageView startAnimating];
    [imageView release];
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Set the frame size to the appropriate values.
        CGRect  myFrame = self.frame;
        myFrame.size.width = 75;
        myFrame.size.height = 75;
        self.frame = myFrame;
        [self imageOfCreat];
        // The opaque property is YES by default. Setting it to
        // NO allows map content to show through any unrendered
        // parts of your view.
        self.opaque = NO;
    }
    return self;
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
