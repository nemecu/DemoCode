//
//  RotationGesture.m
//  Gesture
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-29.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "RotationGesture.h"

@implementation RotationGesture

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
  
    
    rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(actionRotation:)];
    
    
    [self.view addGestureRecognizer:rotation];
    
    
    
}

- (void)actionRotation:(id)sender{
    CGAffineTransform tranform = CGAffineTransformMakeRotation(rotation.rotation);
    [UIView animateWithDuration:0.9f animations:^{
        imageView.transform = tranform;
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
