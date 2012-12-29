//
//  ImageExpandViewController.m
//  ViewDemoSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "ImageExpandViewController.h"

@interface ImageExpandViewController ()

@end

@implementation ImageExpandViewController

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
    NSLog(@"SW -systemVersion %@",[UIDevice currentDevice].systemVersion);
    
    UIImage *zfBGImage = [UIImage imageNamed:@"转发_bg"];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 5.0f) {
        //4.3系统
        zfBGImage = [zfBGImage stretchableImageWithLeftCapWidth:(zfBGImage.size.width*0.75f)
                                                   topCapHeight:zfBGImage.size.height*0.5f];
    }else{
        UIEdgeInsets inset = UIEdgeInsetsMake(zfBGImage.size.height*0.5f - 1,
                                              zfBGImage.size.width*0.75f - 1,
                                              zfBGImage.size.height*0.5f - 1,
                                              zfBGImage.size.width*0.25f - 1);
        zfBGImage = [zfBGImage resizableImageWithCapInsets:inset];
    }
    
    _myImageView = [[UIImageView alloc] initWithFrame:self.myTestView.bounds];
    [_myImageView setImage:zfBGImage];
    [_myImageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
     UIViewAutoresizingFlexibleTopMargin |
     UIViewAutoresizingFlexibleHeight |
     UIViewAutoresizingFlexibleWidth];
    [self.myTestView addSubview:_myImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionIncrease:(id)sender {
    CGRect frame = self.myTestView.frame;
    frame.origin.x +=2;
    frame.origin.y +=2;
    frame.size.width +=5;
    frame.size.height +=5;
    self.myTestView.frame = frame;
}

- (IBAction)actionReduce:(id)sender {
    CGRect frame = self.myTestView.frame;
    frame.origin.x -=2;
    frame.origin.y -=2;
    frame.size.width -=5;
    frame.size.height -=5;
    self.myTestView.frame = frame;
}
- (void)dealloc {
    [_myImageView release];
    [_myTestView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyImageView:nil];
    [self setMyTestView:nil];
    [super viewDidUnload];
}
@end
