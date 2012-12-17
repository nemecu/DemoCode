//
//  SWtouch.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-28.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWtouch.h"

@implementation SWtouch
@synthesize image;
@synthesize imageRect;
@synthesize imageView;
@synthesize btn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    image = [UIImage imageNamed:@"demo.png"];
    CGImageRef rec = image.CGImage;
//    CGImageGetWidth(rec);
//    CGImageGetHeight(rec);
    imageRect = CGRectMake(0, 0, 90, 0);
    imageRect.size.height = 90 * CGImageGetHeight(rec) / CGImageGetWidth(rec);
    imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.image = image;
    imageView.center = CGPointMake(self.view.frame.size.width * 0.5,
                                   self.view.frame.size.height * 0.5);
    [self.view addSubview:imageView];
    

    [self.view addSubview:btn];
    
    isfangfa = YES;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan\n");
    UITouch *touch = [touches anyObject];
    float i = [touch tapCount] * (isfangfa?1.1:0.9);
    imageRect = imageView.frame;
    CGPoint center = imageView.center;
    imageRect.size = CGSizeMake(imageRect.size.width * i, imageRect.size.height * i);
//    [UIView animateWithDuration:0.3f animations:^{
//        
//        imageView.frame = imageRect;
//        self.imageView.center = center;
//    }];
    
    [UIView animateWithDuration:1.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionRepeat
                     animations:^{
                         imageView.frame = imageRect;
                         self.imageView.center = center;
                     }completion:^(BOOL finished) {
                         
                     }];
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [UIView animateWithDuration:1.02 animations:^{
        imageView.center = [touch locationInView:self.view];
    }];
    
}




- (void)viewDidUnload
{
    [self setBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc{
    [imageView release];
    [image release];
    
    [btn release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)actionss:(id)sender {
    isfangfa = !isfangfa;
    if (isfangfa) {
        [btn setTitle:[NSString stringWithFormat:@"现在是放大"] forState:UIControlStateNormal];

    }else{
        [btn setTitle:[NSString stringWithFormat:@"现在是缩小"] forState:UIControlStateNormal];
    }
    
}
@end
