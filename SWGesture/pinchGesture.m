//
//  pinchGesture.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-29.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "pinchGesture.h"
#import "TapGesTure.h"

@implementation pinchGesture

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
//    [imageView setUserInteractionEnabled:YES];
    
    
    UIPinchGestureRecognizer *subpinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(actionPin:)];
    
    [self.view addGestureRecognizer:subpinch];
    [subpinch release];
    pinch.delegate = self;
    
    imageView.frame = CGRectMake(0, 0, 150, 130);
    imageView.center = CGPointMake(160, 230);
    [self.view addSubview:imageView];
}

- (void)actionPin:(id)sender {
//    NSLog(@"hangdle,hangdle,hangdle");
    if ([sender isKindOfClass:[UIPinchGestureRecognizer class]]) {
        NSLog(@"sw-2-pin \n");
        UIPinchGestureRecognizer *sub = (UIPinchGestureRecognizer *)sender;
        CGAffineTransform transform = CGAffineTransformMakeScale([sub scale], [sub scale]);
        [UIView animateWithDuration:0.5f animations:^{
            imageView.transform = transform;
        }];
    }
    CGPoint location = [pinch locationInView:self.view];
    NSLog(@"scale:%f",[pinch scale]);
    NSLog(@"velocity:%f\n\n\n",pinch.velocity);
    
   
    
    
}

- (void)dealloc{
    
    [pinch release];
    [pinch release];
    [super dealloc];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
