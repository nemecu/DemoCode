//
//  LongPressGesture.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-29.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "LongPressGesture.h"

@implementation LongPressGesture

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView = [[UIImageView alloc] initWithImage:
                 [UIImage imageNamed:@"demo.png"]];
    
    imageView.frame = CGRectMake(0, 0, 150, 130);
    imageView.center = CGPointMake(160, 230);
    [self.view addSubview:imageView];
    
    
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(actionLongPress:)];
//    longPress.allowableMovement = 200;
    longPress.minimumPressDuration = 2;
//    longPress.numberOfTapsRequired = 2;
    longPress.numberOfTouchesRequired = 2;
    
    
    [self.view addGestureRecognizer:longPress];
    
    
    
}

- (void)actionLongPress:(id)sender{
    UILongPressGestureRecognizer *ll = (UILongPressGestureRecognizer *)sender;
    if (ll.state == UIGestureRecognizerStateBegan) {
        NSLog(@"longPress---began\n");
    }
    NSLog(@"longPress\n");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"longPress"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
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
