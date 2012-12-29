//
//  ViewController.m
//  BaiduMapSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-5.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Sip2BDMapDelegate.h"

static CGPoint showPoint = {160.0f,250.0f};
static CGPoint hidePoint = {160.0f,670.0f};
static CLLocationCoordinate2D locationCoordinate = {31.290386, 120.662656};
static CLLocationCoordinate2D leftBottomCoordinate = {31.190386, 120.562656};
static CLLocationCoordinate2D rightTopCoordinate = {31.390386, 120.762656};

@interface ViewController()

@property (retain, nonatomic) Sip2BDMapDelegate *sip2Delegate;

@end

@implementation ViewController
@synthesize btnView;
@synthesize isMode;
@synthesize showStatus;
@synthesize myScrollView;
@synthesize POIView;
@synthesize inputCity;
@synthesize inputKey;

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
    isMode = YES;
    isLocation = YES;
    
    self.btnView.center = hidePoint;
    self.btnView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
    
    self.showStatus.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    [self.showStatus setTextAlignment:UITextAlignmentCenter];
    
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    BMKCoordinateRegion region;
    region.center = locationCoordinate;
    region.span = BMKCoordinateSpanMake(0.2, 0.2);
    [_mapView setRegion:region animated:YES];
    [_mapView setShowsUserLocation:YES];
    [_mapView setZoomLevel:16];
    [self.view insertSubview:_mapView belowSubview:self.myScrollView];
    [_mapView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight];

    self.myScrollView.frame = CGRectMake(0, 40, 320, 420);
    [self.myScrollView setClipsToBounds:NO];
    [self.myScrollView setContentSize:CGSizeMake(640, 420)];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.backgroundColor = [UIColor clearColor];
    
    
    self.btnView.layer.borderWidth = 3.0f;
    self.btnView.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnView.frame = CGRectMake(0, 40, 320, 420);
    [self.myScrollView addSubview:self.btnView];
    
    
    self.POIView.layer.borderWidth = 3.0f;
    self.POIView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.POIView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
    self.POIView.frame = CGRectMake(320, 40, 320, 420);
    [self.myScrollView addSubview:self.POIView];
    
    
    
//POI检索
    POISearch  = [[BMKSearch alloc] init];
    POISearch.delegate = self;
    self.inputCity.text = @"北京";
    self.inputKey.text = @"餐馆";
    poiPageIndex = 0;
    
    
    //添加代理
    [self addAllDelegate];
    
}

- (void)viewDidUnload
{
    [self setBtnView:nil];
    [self setShowStatus:nil];
    [self setMyScrollView:nil];
    [self setPOIView:nil];
    [self setInputCity:nil];
    [self setInputKey:nil];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    [_sip2Delegate release];
    [btnView release];
    [showStatus release];
    [myScrollView release];
    [POIView release];
    [inputCity release];
    [inputKey release];
    [super dealloc];
}

#pragma mark - Custom Function

- (void)addAllDelegate{
    _sip2Delegate = [[Sip2BDMapDelegate alloc] init];
}

- (void)hideKeyboard{
    [self.inputKey resignFirstResponder];
    [self.inputCity resignFirstResponder];
}

#pragma mark - action - POI检索

- (IBAction)actionPOISearchWithCity:(id)sender {
    [self hideKeyboard];
    [self actionViewHide:nil];
    if ([self.inputCity.text length] < 1) {
        NSLog(@"sw-2-当前地图内搜索 \n");
        [POISearch poiSearchInCity:nil withKey:self.inputKey.text pageIndex:poiPageIndex];
        poiPageIndex = 0;
    }else{
        NSLog(@"sw-2-poiSearchInCity %@\n",self.inputCity.text );
        [POISearch poiSearchInCity:self.inputCity.text withKey:self.inputKey.text pageIndex:poiPageIndex];
        poiPageIndex ++;
    }
    

}

- (IBAction)actionPOISearchBound:(id)sender {
    [self hideKeyboard];
    [self actionViewHide:nil];
    
    NSString *keyString;
    if ([self.inputKey.text length] > 0) {
        keyString = self.inputKey.text;
    }else{
        keyString = @"餐馆";
    }
    [POISearch poiSearchInbounds:keyString leftBottom:leftBottomCoordinate rightTop:rightTopCoordinate pageIndex:poiPageIndex];
    
}

- (IBAction)actionPOISearchNearBy:(id)sender {
    [self hideKeyboard];
    [self actionViewHide:nil];
    
    NSArray *arr = [NSArray arrayWithArray:[_mapView annotations]];
    [_mapView removeAnnotations:arr];
    
    NSString *keyString;
    if ([self.inputKey.text length] > 0) {
        keyString = self.inputKey.text;
    }else{
        keyString = @"餐馆";
    }
    [POISearch poiSearchNearBy:keyString center:_mapView.userLocation.coordinate radius:1000 pageIndex:poiPageIndex];
}

- (IBAction)actionBusSearch:(id)sender {
    BMKPlanNode *nodeStart = [[BMKPlanNode alloc] init];
    nodeStart.name = @"天安门";
    BMKPlanNode *nodeEnd = [[BMKPlanNode alloc] init];
    nodeEnd.name = @"百度大厦";
    [POISearch transitSearch:@"北京" startNode:nodeStart endNode:nodeEnd];
}

- (IBAction)actionCarsearch:(id)sender {
}

- (IBAction)actionStepSearch:(id)sender {
}




#pragma mark - POI搜索-delegate

- (void)onGetPoiResult:(NSArray *)poiResultList searchType:(int)type errorCode:(int)error{
    if (error == BMKErrorOk) {
        NSLog(@"sw-2-type %d\n",type);
        BMKPoiResult *result = [poiResultList objectAtIndex:0];
        NSLog(@"sw-2-totalPoiNum:%d,currPoiNum:%d,pageNum:%d,pageIndex:%d\n",result.totalPoiNum,result.currPoiNum,result.pageNum,result.pageIndex);
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
//            NSLog(@"sw-2-poi%d : %@\n",i,poi);
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@,%@",
                                poi.name
                                ,poi.address];
            annotation.subtitle = poi.phone;
            annotation.coordinate = poi.pt;
            [_mapView addAnnotation:annotation];
            [annotation release];
        }
//        if (result.pageNum > result.pageIndex) {
//            poiPageIndex = result.pageIndex + 1;
//            [self actionPOISearchNearBy:nil];
//        }else{
//            poiPageIndex = 0;
//        }
        
        for (BMKCityListInfo *cityList in result.cityList) {
            NSLog(@"sw-2- %@:%d\n",cityList.city,cityList.num);
        }
    }else{
        NSLog(@"sw-2-error %d\n\n",error);
    }
}

/**
 *返回公交搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error{
    NSLog(@"sw-2- 返回公交搜索结果\n");
}

/**
 *返回驾乘搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error{
    NSLog(@"sw-2-返回驾乘搜索结果 \n");
}

/**
 *返回步行搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error{
    NSLog(@"sw-2- 返回步行搜索结果\n");
    
}


#pragma mark - action - 路况 及 定位

- (IBAction)actionViewShow:(id)sender {
    [self hideKeyboard];
    
    [UIView animateWithDuration:0.3f animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.myScrollView.center = CGPointMake(self.myScrollView.center.x,
                                               self.view.frame.size.height/2);
//        NSLog(@"sw-2- show%f,%f\n",self.view.center.y,self.view.frame.size.height);

    }];

}

- (IBAction)actionViewHide:(id)sender {
    [self hideKeyboard];
    
    [UIView animateWithDuration:0.3f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.myScrollView.center = CGPointMake(self.myScrollView.center.x,
                                               self.view.frame.size.height +self.myScrollView.frame.size.height);
//        NSLog(@"sw-2-hide %f\n",self.view.center.y);
    }];
}

- (IBAction)actionAddAnnotation:(id)sender {
    static double increment = 0.0f;
    increment+=0.01f;
    [self actionViewHide:nil];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = locationCoordinate.latitude + increment;
    coordinate.longitude = locationCoordinate.longitude + increment;
    annotation.coordinate = coordinate;
    annotation.title = @"SW北京";
    annotation.subtitle = @"SW-SUB-title";
    [_mapView addAnnotation:annotation];
    self.showStatus.text = [NSString stringWithFormat:@"添加 大头钉"];

}

- (IBAction)actionRemoveAnnotation:(id)sender {
//    [self actionViewHide:nil];
//    NSArray *arr = [mapView annotations];
//    [mapView removeAnnotations:arr];
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    self.showStatus.text = [NSString stringWithFormat:@"移除 大头钉"];
}

- (IBAction)actionAddOverLayer:(id)sender {
    [self actionViewHide:nil];
    CLLocationCoordinate2D coor[2];
    coor[0].latitude = 39.315f;
    coor[0].longitude = 116.304f;
    coor[1].latitude = 39.515f;
    coor[1].longitude = 116.504;
    
    BMKPolyline *poliLayer = [BMKPolyline polylineWithCoordinates:coor count:2];
    [_mapView addOverlay:poliLayer];
    self.showStatus.text = [NSString stringWithFormat:@"添加直线"];
}

- (IBAction)actionAddTriangle:(id)sender {
    [self actionViewHide:nil];
    CLLocationCoordinate2D coords[3] = {0};
    coords[0].latitude = 39;
    coords[0].longitude = 116; 
    coords[1].latitude = 38;
    coords[1].longitude = 115;
    coords[2].latitude = 38;
    coords[2].longitude = 117;
    
    BMKPolygon *polygon = [BMKPolygon polygonWithCoordinates:coords count:3];
    [_mapView addOverlay:polygon];
    
    self.showStatus.text = [NSString stringWithFormat:@"添加-三角"];
}

- (IBAction)actionAddcircle:(id)sender {
    [self actionViewHide:nil];
    CLLocationCoordinate2D coor;
    coor.latitude = 40;
    coor.longitude = 116;
    BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:coor radius:90000];
    circleOverLayer = [circle retain];
    [_mapView addOverlay:circle];
    
    self.showStatus.text = [NSString stringWithFormat:@"添加-圆"];
}

- (IBAction)removeOverLayer:(id)sender {
    [self actionViewHide:nil];
    NSArray *arrOfoverLayer = [NSArray arrayWithArray:[_mapView overlays]];
    [_mapView removeOverlays:arrOfoverLayer];
    [circleOverLayer release];
    self.showStatus.text = [NSString stringWithFormat:@"删除 OverLayer"];
}

- (IBAction)actionZhiHuiGuan:(id)sender {
    [self actionViewHide:nil];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(31.290386, 120.662656) animated:YES];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(31.290386, 120.662656);
    annotation.title = @"知惠馆";
    [_mapView setZoomLevel:17];
    [_mapView addAnnotation:annotation];
    
    self.showStatus.text = [NSString stringWithFormat:@"定位-知惠馆"];
    
}

- (IBAction)actionZoomIn:(id)sender {
    BOOL status = [_mapView zoomIn];
    if (status) {
        self.showStatus.text = [NSString stringWithFormat:@"地图 放大-成功:%d",_mapView.zoomLevel];
    }else{
        self.showStatus.text = [NSString stringWithFormat:@"地图 放大-失败:%d",_mapView.zoomLevel];
    }
}

- (IBAction)actionZoomOut:(id)sender {
    BOOL status = [_mapView zoomOut];
    if (status) {
        self.showStatus.text = [NSString stringWithFormat:@"地图 缩小-成功:%d",_mapView.zoomLevel];
    }else{
        self.showStatus.text = [NSString stringWithFormat:@"地图 缩小-失败:%d",_mapView.zoomLevel];
    }
}

- (IBAction)actionChangeMode:(id)sender {
    [self actionViewHide:nil];
    if (isMode) {
        [_mapView setMapType:BMKMapTypeTrafficOn];
        self.showStatus.text = [NSString stringWithFormat:@"地图Mode-交通"];
    }else{
        [_mapView setMapType:BMKMapTypeStandard];
        self.showStatus.text = [NSString stringWithFormat:@"地图Mode-标准"];
    }
    isMode = !isMode;
    
}

- (IBAction)actionStartLocation:(id)sender {
    [self actionViewHide:nil];
    if (![_mapView showsUserLocation]) {
        [_mapView setShowsUserLocation:YES];
        
        self.showStatus.text = [NSString stringWithFormat:@"定位中...."];
    }else{
        [_mapView setShowsUserLocation:NO];
        self.showStatus.text = [NSString stringWithFormat:@"停止定位"];
    }
    isLocation = !isLocation;
}

#pragma mark 代理转换
- (IBAction)actionBindDelegate:(id)sender {
    _mapView.delegate = _sip2Delegate;
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
//        BMKCoordinateRegion region;
//        region.center = locationCoordinate;
//        region.span = BMKCoordinateSpanMake(1, 1);
//        [mapView setRegion:region animated:YES];
//        [mapView setZoomLevel:16];
        [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
        
//        mapView.showsUserLocation = NO;
        
//        [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        
    }
}













@end
