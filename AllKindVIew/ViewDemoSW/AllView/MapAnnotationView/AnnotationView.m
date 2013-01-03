//
//  AnnotationView.m
//  BaiduMapSW
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "AnnotationView.h"

#define AV_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]                       //屏幕尺寸
#define AV_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width             //屏幕宽度
#define AV_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height           //屏幕高度
#define AV_ANIMATION_DURATION 1

static CGSize sViewMiniSize = {50, 50};
static CGSize sViewMaxSize = {60, 60};


@interface AnnotationView()

//@property (nonatomic, assign) BOOL status;
@property (nonatomic, retain) UITextField *textFieldTitle;
@property (nonatomic, retain) UIImageView *imageViewOfFlag;
@property (nonatomic, retain) UIImageView *imageViewOfArrow;

@end

@implementation AnnotationView

- (void)dealloc
{
    [_textFieldTitle release];
    [_imageViewOfArrow release];
    [_imageViewOfFlag release];
    [super dealloc];
}

- (id)init
{
    self = [self initWithFrame:CGRectMake(50,
                                          50,
                                          sViewMiniSize.width,
                                          sViewMiniSize.height)];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size = sViewMiniSize;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addBGImageView];
        [self addTextField];
        [self addImageView];
        [self addButton];
        
        [self resetStatus];
    }
    return self;
}

- (void)addBGImageView{
    UIImageView *temp = [[UIImageView alloc] init];
    self.imageViewOfArrow = temp;
    [temp release];
    
    UIImage *imageArrow = [UIImage imageNamed:@"p_bg"];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 5.0f) {
        //4.3系统
        imageArrow = [imageArrow stretchableImageWithLeftCapWidth:1
                                                   topCapHeight:imageArrow.size.height*0.5f];
    }else{
        UIEdgeInsets inset = UIEdgeInsetsMake(0,
                                              1,
                                              0,
                                              imageArrow.size.width - 2);
        imageArrow = [imageArrow resizableImageWithCapInsets:inset];
    }
    [_imageViewOfArrow setImage:imageArrow];
    [_imageViewOfArrow setFrame:CGRectMake(sViewMaxSize.width*0.5f, 0, sViewMaxSize.width, sViewMaxSize.height)];
    
    [self addSubview:_imageViewOfArrow];
}

- (void)addTextField{
    UITextField *temp = [[UITextField alloc] init];
    self.textFieldTitle = temp;
    [temp release];
    
    [self addSubview:_textFieldTitle];
    
    self.textFieldTitle.text = @"这是我的测试TEst";
}

- (void)addImageView{
    UIImageView *temp = [[UIImageView alloc] init];
    self.imageViewOfFlag = temp;
    [_imageViewOfFlag setImage:[UIImage imageNamed:@"p_big"]];
    [temp release];
    [_imageViewOfFlag setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    
    [self addSubview:_imageViewOfFlag];
}

- (void)addButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
//    [btn setAutoresizingMask:
//     UIViewAutoresizingFlexibleTopMargin |
//     UIViewAutoresizingFlexibleLeftMargin |
//     UIViewAutoresizingFlexibleHeight];
    [btn addTarget:self action:@selector(actionClickCircle:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


#pragma mark - animation

// 缩小
- (void)animationZoomOut{
    [UIView animateWithDuration:AV_ANIMATION_DURATION
                     animations:^{
                         //View尺寸扩大
                         CGRect frame = self.frame;
                         frame.size = CGSizeZero;
                         self.frame = frame;
                         
                         //隐藏右箭头
                         [self setAllViewHidden:YES];
                         
                     } completion:^(BOOL finished) {
                         [self animationExtend];
                     }];
}


//扩大
- (void)animationZoomIn{
    [UIView animateWithDuration:AV_ANIMATION_DURATION
                     animations:^{
                         //View尺寸扩大
                         CGRect frame = self.frame;
                         frame.size = CGSizeMake(sViewMaxSize.width, sViewMaxSize.height);
                         self.frame = frame;
                         
                         //显示右箭头
                         [self setAllViewHidden:NO];
                         
                     } completion:^(BOOL finished) {
                         [self animationExtend];
                     }];
}

//收缩
- (void)animationShrink{
    
}

//伸展
- (void)animationExtend{
    [UIView animateWithDuration:AV_ANIMATION_DURATION
                     animations:^{
                         
                         CGSize size = [_textFieldTitle.text sizeWithFont:_textFieldTitle.font
                                                        constrainedToSize:CGSizeMake(AV_SCREEN_WIDTH, sViewMaxSize.height)
                                                            lineBreakMode:UILineBreakModeWordWrap];
                         
                         //textFiels尺寸
                         _textFieldTitle.frame = CGRectMake(sViewMaxSize.width+5, 0, size.width, sViewMaxSize.height);
                         
                         //View尺寸
                         CGRect frameOfView = self.frame;
                         frameOfView.size.width = sViewMaxSize.width+ 5.0f + size.width + 5.0f + sViewMaxSize.width*0.5f;
                         self.frame = frameOfView;
                         
                         //BGImage尺寸
                         CGRect frameOfArrow = _imageViewOfArrow.frame;
                         frameOfArrow.size.width = sViewMaxSize.width + 5.0f*2 + size.width;
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Custom Function

- (void)resetStatus{
    _imageViewOfArrow.hidden = YES;
    _textFieldTitle.hidden = YES;
    self.hidden = YES;
}

- (void)setFlagImage:(UIImage *)image{
    [_imageViewOfFlag setImage:image];
}

- (void)setImageName:(NSString *)imageName andTitle:(NSString *)title{
    [_imageViewOfFlag setImage:[UIImage imageNamed:imageName]];
    _textFieldTitle.text = title;
}

- (void)setAllViewHidden:(BOOL)isHidden{
    _imageViewOfArrow.hidden = isHidden;
    _textFieldTitle.hidden = isHidden;
    _imageViewOfFlag.hidden = isHidden;
}

- (void)setShow:(BOOL)isShow{
    if (isShow) {
        //显示
        NSLog(@"SW -Log 显示");
        self.hidden = NO;
        [self animationZoomIn];
    }else{
        //隐藏
        NSLog(@"SW -Log 隐藏");
    }
}

- (void)setAnnotationViewPoint:(CGPoint)location{
    
}


#pragma mark - action

- (void)actionClickCircle:(id)sender{
    
}

- (void)actionClickrect:(id)sender{
    
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
