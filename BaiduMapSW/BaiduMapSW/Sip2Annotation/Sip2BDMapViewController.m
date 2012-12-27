//
//  Sip2BDMapViewController.m
//  BaiduMapSW
//
//  Created by shaowei on 12-12-27.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "Sip2BDMapViewController.h"

static CLLocationCoordinate2D locationCoordinate = {31.290386, 120.662656};
static CLLocationCoordinate2D leftBottomCoordinate = {31.190386, 120.562656};
static CLLocationCoordinate2D rightTopCoordinate = {31.390386, 120.762656};

@interface Sip2BDMapViewController ()

@property (nonatomic, retain) BMKMapView *mapView;

@end

@implementation Sip2BDMapViewController

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
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    BMKCoordinateRegion region;
    region.center = locationCoordinate;
    region.span = BMKCoordinateSpanMake(0.1, 0.1);
    [_mapView setRegion:region animated:YES];
    [_mapView setShowsUserLocation:YES];
    [_mapView setZoomLevel:16];
    [self.view addSubview:_mapView];
    [_mapView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight];
    
    [self testFunc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_mapView release];
    [super dealloc];
}

#pragma mark Function

- (void)testFunc{
    
}

#pragma mark action

- (IBAction)actionAddAnnotation:(id)sender {
    

    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 39.915f;
    coordinate.longitude = 116.404f;
    annotation.coordinate = coordinate;
    annotation.title = @"SW北京";
    annotation.subtitle = @"SW-SUB-title";
    [_mapView addAnnotation:annotation];
    
}


#pragma mark - delegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView1 viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        static NSString *annotationViewID = @"annotationID";
        BMKAnnotationView *pin = [mapView1 dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
        
        if (pin == nil) {
            pin = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                   reuseIdentifier:annotationViewID];
        }
        
        ((BMKPinAnnotationView *)pin).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView *)pin).animatesDrop = YES;
        
        pin.annotation = annotation;
        
        pin.canShowCallout = YES;
        //        [pin setSelected:YES animated:YES];
        pin.draggable = YES;
        
        //        pin.h
        
        pin.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.1f];
        pin.calloutOffset = CGPointMake(0, 10);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pin.leftCalloutAccessoryView = btn;
        pin.rightCalloutAccessoryView = btn;
        
        return pin;
    }
    
    return nil;
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    //添加线
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polyLineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polyLineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5f];
        polyLineView.lineWidth = 5.0f;
        return polyLineView;
    }
    
    //添加三角
    if ([overlay isKindOfClass:[BMKPolygon class]]) {
        BMKPolygonView *polygonView = [[[BMKPolygonView alloc] initWithOverlay:overlay] autorelease];
        
        polygonView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.6];
        polygonView.lineWidth = 5.0;
        return polygonView;
    }
    
    //添加圆
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        BMKCircleView *circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.strokeColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
        circleView.fillColor = [[UIColor cyanColor]colorWithAlphaComponent:0.6];
        circleView.lineWidth = 6.0;
        return [circleView autorelease];
    }
    
    
    return nil;
}

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView{
    NSLog(@"sw-2- delegate 开始定位\n");
    
}

- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView{
    [mapView setZoomLevel:16];
    NSLog(@"sw-2- delegate 停止定位\n");
    BMKCoordinateRegion subRegion = mapView.region;
    subRegion.center = mapView.userLocation.coordinate;
    [mapView setRegion:subRegion];
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = mapView.userLocation.coordinate;
    annotation.title = @"我的位置";
    [mapView addAnnotation:annotation];
    [annotation release];
    
    
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    //    [mapView setZoomLevel:16];
    NSLog(@"sw-2- delegate 更新位置：%d\n",mapView.zoomLevel);
    if (!mapView.userLocationVisible) {
        NSLog(@"sw-2- delegate 显示-更新位置\n");
        BMKCoordinateRegion region;
        region.center = locationCoordinate;
        region.span = BMKCoordinateSpanMake(1, 1);
        [mapView setRegion:region animated:YES];
        [mapView setZoomLevel:16];
        
        mapView.showsUserLocation = NO;
        
        //        [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        
    }
}





@end
