//
//  AnnotationViewController.m
//  ViewDemoSW
//
//  Created by shaowei on 12-12-29.
//  Copyright (c) 2012年 LianZhan. All rights reserved.
//

#import "AnnotationViewController.h"
#import "AnnotationView.h"

@interface AnnotationViewController ()

@property (nonatomic, retain) AnnotationView *testView;

@end

@implementation AnnotationViewController

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
    AnnotationView *annotationView = [[AnnotationView alloc] init];
    self.testView = annotationView;
    [self.view addSubview:annotationView];
    [annotationView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_testView release];
    [super dealloc];
}

- (IBAction)actionTest:(id)sender {
    static BOOL isShow = NO;
    isShow = !isShow;
    [_testView setShow:isShow];
}
@end
