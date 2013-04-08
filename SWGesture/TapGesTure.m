//
//  TapGesTure.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-28.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "TapGesTure.h"

@implementation TapGesTure
@synthesize tapGestrue;

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
    
    imageView = [[UIImageView alloc] initWithImage:
                 [UIImage imageNamed:@"demo.png"]];
    
    
    pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(actionPin)];
}


- (void)viewDidUnload
{
    [self setTapGestrue:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(actionPin)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)actionPin:(id)sender {
    NSLog(@"hangdle,hangdle,hangdle");
    CGPoint location = [pinGesture locationInView:self.view];
    NSLog(@"scale:%f",[pinGesture scale]);
    NSLog(@"velocity:%f",pinGesture.velocity);
    
    CGAffineTransform transform = CGAffineTransformMakeScale([pinGesture scale], 0.5);
    [UIView animateWithDuration:0.5f animations:^{
        imageView.transform = transform;
    }];
}

- (IBAction)actionTap:(id)sender {
    NSLog(@"SW -class %@",NSStringFromClass([sender class]));
    CGPoint pp = [tapGestrue locationInView:self.view];
    NSLog(@"actionTap:%f,%f\n",pp.x,pp.y);
    CGPoint location = [self.tapGestrue locationInView:self.view];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap.png"]];
    imageView.center = location;
    [self.view addSubview:imageView];
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         imageView.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         [imageView removeFromSuperview];
                     }];
    
}
- (void)dealloc {
    [imageView release];
    [pinGesture release];
    [swipeGesture release];
    [rotationGesture release];
    [panGesture release];
    [lonGesture release];
    [tapGestrue release];
    [super dealloc];
}
@end
