//
//  ProgressGradientViewController.m
//  ViewDemoSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "ProgressGradientViewController.h"
#import "ProgressView.h"
#import "GradientView.h"

@interface ProgressGradientViewController ()

@property (nonatomic, retain) ProgressView *testProgressView;

@end

@implementation ProgressGradientViewController

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
    [self addGradientView];
    [self addProgressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_testProgressView release];
    [super dealloc];
}

#pragma mark AddView

- (void)updateProgress{
    static CGFloat subValue = 0.0f;
    static CGFloat interval = 0.01f;
    subValue+= interval;
    if (subValue>1 || subValue < 0) {
        interval = - interval;
    }
    
    [self.testProgressView setProgressValue:subValue];
}

- (void)addProgressView{
    _testProgressView = [[ProgressView alloc] initWithFrame:CGRectMake(20, 20, 280, 5)];
    
    [self.view addSubview:_testProgressView];
    NSLog(@"SW - jiehsu");
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (void)addGradientView{
    GradientView *gradientView = [[GradientView alloc] initWithFrame:CGRectMake(10, 100, 300, 45)];
    [self.view addSubview:gradientView];
    [gradientView release];
}

@end
