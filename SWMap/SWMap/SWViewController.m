//
//  SWViewController.m
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-4.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWViewController.h"
#import "SWAnnotation.h"
#import "AnnotationViewSW.h"




static int kNumOfScrollPage = 2;
static CGPoint kScrillCenterShow = {160,270};
static CGPoint kScrillCenterHidden = {160,750};


static float LATITUDE = 31.288525;
static float LONGITUDE = 120.666355;

//@implementation SWAnnotation
//-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
//    
//}
//@end

@interface SWViewController()

- (void)addAnnotation:(int)type;

@end


@implementation SWViewController
@synthesize libMapView;
@synthesize myMap;
@synthesize Test;
@synthesize geocoder;
@synthesize locationView;
@synthesize showView1;
@synthesize myScrollView;

//@synthesize tabbarController;


- (void)scrollOfInit{
    [self.myScrollView setContentSize:CGSizeMake(320 * kNumOfScrollPage, self.myScrollView.frame.size.height)];
    self.myScrollView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.myScrollView.center = kScrillCenterShow;
    [self.myScrollView addSubview:self.showView1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self scrollOfInit];
    
    [self gotoLocation:CLLocationCoordinate2DMake(LATITUDE, LONGITUDE)];
    
    self.libMapView.hidden = YES;
    
    SWAnnotation *annotation = [[SWAnnotation alloc] init];
    annotation.latitude = LATITUDE;
    annotation.longitude = LONGITUDE;
    [self.myMap addAnnotation:annotation];
    self.myMap.delegate = self;
    
    [self.myMap setMapType:MKMapTypeStandard];
    
    self.myMap.showsUserLocation = YES;
   
    
    ii  = 0;
    
    arrAnnotation = [[NSMutableArray alloc] init];
    
    
//    self.tabbarController = [[UITabBarController alloc] init];
    
//    SWViewController *viewCon = [[SWViewController alloc] init];
//    SWLocation *loca = [[SWLocation alloc] init];
//    NSArray *arr = [[NSArray alloc] initWithObjects:viewCon,loca, nil];
    
//    [self.tabbarController setViewControllers:arr animated:YES];
    
    //反向编码解析
    
//    geocoder = [[CLGeocoder alloc] init];
}

- (void)gotoLocation:(CLLocationCoordinate2D)location{
    MKCoordinateRegion newRegion;
//    31.288525,120.666355
    newRegion.center.latitude = location.latitude;
    newRegion.center.longitude = location.longitude;
    newRegion.span.latitudeDelta = 1;
    newRegion.span.longitudeDelta = 0.1;
    
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(location.latitude, location.longitude);
//    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(center, 8000, 1000);
//    
//    newRegion = [self.myMap regionThatFits:newRegion];
    
    
    [self.myMap setRegion:newRegion animated:YES];
    
}

#pragma mark - private方法

- (void)addAnnotation:(int)type{
    ii += 0.1;
    [self gotoLocation:CLLocationCoordinate2DMake(LATITUDE + ii, LONGITUDE + ii)];
    SWAnnotation *annotation = [[SWAnnotation alloc] init];
    annotation.latitude = LATITUDE + ii;
    annotation.longitude = LONGITUDE + ii;
    
    annotation.type = type;
    
    annotation.tag = [arrAnnotation count];
    
    [arrAnnotation addObject:annotation];
    
    [self.myMap addAnnotation:annotation];
}



#pragma mark - action方法

- (IBAction)actionScrollView:(id)sender {
    if (CGPointEqualToPoint(self.myScrollView.center, kScrillCenterShow)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.myScrollView.center = kScrillCenterHidden;
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.myScrollView.center = kScrillCenterShow;
        }];
    }
}

- (IBAction)actionSW:(id)sender {
    [self actionScrollView:nil];
    double meter = MKMetersPerMapPointAtLatitude(32);
    NSLog(@"sw-2-meter %lf\n",meter);
}

- (IBAction)actionAddAnnotation:(id)sender {
    [self actionScrollView:nil];
//    if ([self.myMap.annotations count] > 0) {
//        for (id aa in self.myMap.annotations) {
//            if ([aa isKindOfClass:[SWAnnotation class]]) {
//                NSLog(@"aa is  class\n");
//                [self.myMap removeAnnotations:self.myMap.annotations];
//            }
//            
//        }
//    
//    }
//    [self.myMap removeAnnotations:self.myMap.annotations];
   
    
    [self addAnnotation:0];
    
    
    
}

- (IBAction)actionDelete:(id)sender {
    [self actionScrollView:nil];
    [self.myMap removeAnnotations:self.myMap.annotations];
//    MKMapRect test = self.myMap.visibleMapRect;
//    NSLog(@"%f,%f,%f,%f\n",test.origin.x,test.origin.y,test.size.width,test.size.height);
//    
////    CGRect zuobiao= [self.myMap conve];
//    
//    MKMapRect mapRec = MKMapRectMake(20, 20, 100, 100);
//    [self.myMap setVisibleMapRect:mapRec animated:YES];
    
}

- (IBAction)actionMapRec:(id)sender {
    [self actionScrollView:nil];
    MKMapRect mapRectOrigin = self.myMap.visibleMapRect;
    NSLog(@"%f,%f,%f,%f\n",mapRectOrigin.origin.x,
          mapRectOrigin.origin.y,
          mapRectOrigin.size.width,
          mapRectOrigin.size.height);
    
    //    CGRect zuobiao= [self.myMap conve];
    
    UIEdgeInsets egdeInset = UIEdgeInsetsMake(1, 1, 1, 1);
    MKMapRect mapRec = [self.myMap mapRectThatFits:mapRectOrigin edgePadding:egdeInset];
//    [self.myMap setVisibleMapRect:mapRec animated:YES];
    [self.myMap setVisibleMapRect:mapRectOrigin edgePadding:egdeInset animated:YES];

}



- (IBAction)actionVisibleRect:(id)sender {
    [self actionScrollView:nil];
    //这是一个2维平面，根据缩放的比例不同而变化，当你放到最1级时，就懂了（0，0，320，460）
    CGRect frame = self.myMap.annotationVisibleRect;
    NSLog(@"annotationVisibleRect:%f,%f,%f,%f\n",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
}

- (IBAction)actionSelectAnnotation:(id)sender {
    [self actionScrollView:nil];
    [self.myMap selectAnnotation:(SWAnnotation *)[arrAnnotation lastObject] animated:YES];
}

- (IBAction)actionTrackingMode:(id)sender {
    [self actionScrollView:nil];
    [self.myMap setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
}

- (IBAction)actionAnnotationsInMapRect:(id)sender {
    [self actionScrollView:nil];
    MKMapRect mapRct = self.myMap.visibleMapRect;
    
    NSSet *set =  [self.myMap annotationsInMapRect:mapRct];
    for (id tt in set) {
        if ([tt isKindOfClass:[SWAnnotation class]]) {
            SWAnnotation *subtt = (SWAnnotation *)tt;
            NSLog(@"set-tag:%d\n",subtt.tag);
        }else{
            NSLog(@"set-not-class\n");
        }
    }
}

- (IBAction)actionAddLocationView:(id)sender {
    [self actionScrollView:nil];
    if (!locationView) {
        locationView = [[SWLocation alloc] init];
    }
    
    [self.view addSubview:locationView.view];
//    [locationView release];
  
    
}

- (IBAction)actionShowLocation:(id)sender {
    [self actionScrollView:nil];
}

- (IBAction)actionAddAnnotationOfAnimation:(id)sender {
    [self actionScrollView:nil];
    [self addAnnotation:1];
}



#pragma mark - delegate 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    // if it's the user location, just return nil.为（showsUserLocation）显示自己的位置准备的
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[SWAnnotation class]]) {
        
        SWAnnotation *annotationOfTmp = (SWAnnotation *)annotation;
        
        static NSString *pinIdentifier = @"pinIdentifier";
        
        AnnotationViewSW * annotationView = (AnnotationViewSW *)[self.myMap dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
        
        if (!annotationView) {
            
            switch (annotationOfTmp.type) {
                    
                case 0:
                {
                    static NSString *pinIdentifier = @"pinIdentifier";
                    
                    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[self.myMap dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
                    
                    if (!annotationView) {
                        NSLog(@"xin jian\n");
                        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                                              reuseIdentifier:pinIdentifier];
                        annotationView.pinColor = MKPinAnnotationColorPurple;
                        //            annotationView.animatesDrop = YES;
                        annotationView.canShowCallout = YES;
                        [annotationView setDraggable:YES];
                        
                        //            NSString *path = [[NSBundle mainBundle] pathForResource:@"icon57" ofType:@".png"];
                        //            annotationView.image = [UIImage imageNamed:@"icon57.png"];
                        annotationView.animatesDrop = YES;
                        
                        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
                        [rightButton addTarget:self
                                        action:@selector(actionTest:)
                              forControlEvents:UIControlEventTouchUpInside];
                        annotationView.rightCalloutAccessoryView = rightButton;
                        
                        UIImageView *imageLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon57.png"]];
                        imageLeft.frame = CGRectMake(0, 0, 30, 30);
                        annotationView.leftCalloutAccessoryView = imageLeft;
                        [imageLeft release];
                        
                        return [annotationView autorelease];
                        
                        break;
                    }
                    
                }
                    
                case 1:
                {
                    NSLog(@"xin jian\n");
                    AnnotationViewSW *annotationView = [[AnnotationViewSW alloc] initWithAnnotation:annotation
                                                                                    reuseIdentifier:pinIdentifier];
                    //            annotationView.pinColor = MKPinAnnotationColorPurple;
                    //            annotationView.animatesDrop = YES;
                    annotationView.canShowCallout = YES;
                    [annotationView setDraggable:YES];
                    
                    //            NSString *path = [[NSBundle mainBundle] pathForResource:@"icon57" ofType:@".png"];
                    //            annotationView.image = [UIImage imageNamed:@"icon57.png"];
                    //            annotationView.animatesDrop = YES;
                    
                    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
                    [rightButton addTarget:self
                                    action:@selector(actionTest:)
                          forControlEvents:UIControlEventTouchUpInside];
                    annotationView.rightCalloutAccessoryView = rightButton;
                    
                    UIImageView *imageLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon57.png"]];
                    imageLeft.frame = CGRectMake(0, 0, 30, 30);
                    annotationView.leftCalloutAccessoryView = imageLeft;
                    [imageLeft release];
                    
                    return [annotationView autorelease];
                    break;
                }
                    
                
            }    
            
            
            
            
        }else{
            NSLog(@"chong zai\n");
            return annotationView;
        }
    }else{
        return nil;
    }
    
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//    
//}
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    
//}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapView--Will--StartLoadingMap\n");
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapView--DidFinish--StartLoadingMap\n");
    
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
   NSLog(@"mapView--FailLoad--StartLoadingMap\n"); 
}
//
//// mapView:viewForAnnotation: provides the view for each annotation.
//// This method may be called for all or some of the added annotations.
//// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
//
//// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
//// The delegate can implement this method to animate the adding of the annotations views.
//// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    NSLog(@"didAddAnnotationViews\n");
}
//
//// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"calloutAccessoryControlTapped\n");
}
//
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"didSelectAnnotationView\n");
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"didDeselectAnnotationView\n");
}
//
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
     NSLog(@"mapViewWillStartLocatingUser-开始追踪用户位置\n");
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView{
     NSLog(@"mapViewWillStartLocatingUser-停止追踪用户位置\n");
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    NSLog(@"didUpdateUserLocation-更新用户位置时调用，heading改变时也调用:%@\n,sub:%@\n,location:%@\n\n",
//          self.myMap.userLocation.heading,self.myMap.userLocation.subtitle,self.myMap.userLocation.location);
    
}
//- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(NA, 4_0);
//
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState 
   fromOldState:(MKAnnotationViewDragState)oldState {
    
    NSLog(@"didChangeDragState-annotation改变了状态\n");
    
    if (newState == MKAnnotationViewDragStateEnding) {
        SWAnnotation *an = (SWAnnotation *)(view.annotation);
        NSLog(@"la:%f,LO:%f,%f\n",an.coordinate.latitude,an.coordinate.longitude,an.longitude);
    }
    
    
    
}
//
//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(NA, 4_0);
//
//// Called after the provided overlay views have been added and positioned in the map.
//- (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews NS_AVAILABLE(NA, 4_0);
//
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0){
    NSLog(@"didChangeUserTrackingMode-追踪模式改变\n");
}

#pragma mark - system方法

- (void)viewDidUnload
{
    [self setMyMap:nil];
    [self setTest:nil];
    [self setLibMapView:nil];
    [self setShowView1:nil];
    [self setMyScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [locationView release];
//    [tabbarController release];
    [arrAnnotation release];
    [myMap release];
    [Test release];
    [libMapView release];
    [showView1 release];
    [myScrollView release];
    [super dealloc];
}
@end
