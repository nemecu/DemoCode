//
//  SwipeGesture.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-29.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SwipeGesture.h"

@implementation SwipeGesture

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
    
    imageView.frame = CGRectMake(0, 0, 150, 130);
    imageView.center = CGPointMake(160, 230);
    [self.view addSubview:imageView];
    
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(actionSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipe];
    
    
    swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(actionSwipe:)];
    swipe1.direction = UISwipeGestureRecognizerDirectionUp;
    
    
    [self.view addGestureRecognizer:swipe1];
    
}

- (void)actionSwipe:(id)sender{
    NSLog(@"swipe swipe swipe");
    UISwipeGestureRecognizer *ss = (UISwipeGestureRecognizer *)sender;
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]]) {
//        NSLog(@"is swipe class\n");
        
        if (ss == swipe) {
            NSLog(@"is swipe \n");
        }
        if (ss == swipe1) {
            NSLog(@"is swipe1 \n");
        }
    }
    
    switch (ss.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"left");
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"right");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"down");
            break;
            
        default:
            break;
    }
    
    
    CGPoint location = [swipe locationInView:self.view];
    NSLog(@"x:%f,y:%f\n\n",location.x,location.y);
    imageView.center = location;
    imageView.alpha = 0;
   
    [UIView animateWithDuration:0.8f
                     animations:^{
                         imageView.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         imageView.alpha = 0.0f;
                     }];
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
