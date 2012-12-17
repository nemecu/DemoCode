//
//  SWLocation.m
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-11.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWLocation.h"


@implementation SWLocation
@synthesize locationManager;
@synthesize textShow;
@synthesize lableShow;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    locationManager  = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDistanceFilter:100];
//    [locationManager startUpdatingLocation];
    
    
    [self headingTest];
//    [self LocationInit];
//    [self AvailableOfAll];
}

- (void)viewDidUnload
{
    [self setTextShow:nil];
    [self setLableShow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 自定义方法
- (void)headingTest{
    
}

- (void)LocationInit{
    
}

- (IBAction)actionStart:(id)sender {
    [self.locationManager startUpdatingHeading];
}

- (IBAction)actionEnd:(id)sender {
    [self.locationManager stopUpdatingHeading];
}

- (IBAction)actionDiamiss:(id)sender {
    [self.locationManager dismissHeadingCalibrationDisplay];
}

- (IBAction)actionBackView:(id)sender {
    [self.view removeFromSuperview];
}

- (void)AvailableOfAll{
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        /*
         这种方法显示装置能是否报告基于显著位置更新变化而已。(重要的地点更换监测主要包括检测细胞的变化与设备有关塔目前。)这种能力提供了极大的节省电源,可广泛应用于想一个用户的大概位置跟踪,并且不需要高度精确的位置信息。
         */
        NSLog(@"significantLocationChangeMonitoringAvailable-显著位置更新变化-Yes\n");
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"显著位置更新变化-Yes\n"];
    }else{
       NSLog(@"significantLocationChangeMonitoringAvailable-显著位置更新变化-No\n"); 
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"显著位置更新变化-no\n"];
    }
    
    if ([CLLocationManager headingAvailable]) {
        NSLog(@"headingAvailable-yes\n ");
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"headingAvailable-yes"];
    }else{
        NSLog(@"headingAvailable-no\n ");
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"headingAvailable-no"];
    }
    
    if ([CLLocationManager regionMonitoringAvailable]) {
        NSLog(@"regionMonitoringAvailable-yes\n ");
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"regionMonitoringAvailable-yes\n"];
    }else{
        NSLog(@"regionMonitoringAvailable-no\n ");
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"regionMonitoringAvailable-no\n"];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"locationServicesEnabled-yes\n"];
    }else{
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"locationServicesEnabled-no\n"];
    }
    
    if ([CLLocationManager regionMonitoringEnabled]) {
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"regionMonitoringEnabled-yes\n"];
    }else{
        self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"regionMonitoringEnabled-no\n"];
    }
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined\n");
            self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"kCLAuthorizationStatusNotDetermined\n"];
            break;
            
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted\n");
            self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"kCLAuthorizationStatusRestricted\n"];
            break;
            
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied\n");
            self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"kCLAuthorizationStatusDenied\n"];
            break;
            
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized\n");
            self.lableShow.text = [self.lableShow.text stringByAppendingFormat:@"kCLAuthorizationStatusAuthorized\n"];
            break;
            
        default:
            break;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.lableShow resignFirstResponder];
    [self.textShow resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

#pragma mark - delegate

/*
 *  locationManager:didUpdateToLocation:fromLocation:
 *  
 *  Discussion:
 *    Invoked when a new location is available. oldLocation may be nil if there is no previous location
 *    available.
 */
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
}

/*
 *  locationManager:didUpdateHeading:
 *  
 *  Discussion:
 *    Invoked when a new heading is available.
 */
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    
//    NSLog(@"magneticHeading:%lf\n trueHeading:%lf\n headingAccuracy:%lf\n timestamp:%@\n description:%@\n x:%lf\n y:%lf\n z:%lf\n**************",
//          newHeading.magneticHeading,
//          newHeading.trueHeading,
//          newHeading.headingAccuracy,
//          newHeading.timestamp,
//          newHeading.description,
//          newHeading.x,
//          newHeading.y,
//          newHeading.z
//          );
    self.lableShow.text = [NSString stringWithFormat:@"magneticHeading:%lf\n trueHeading:%lf\n headingAccuracy:%lf\n timestamp:%@\n description:%@\n x:%lf\n y:%lf\n z:%lf\n**************",
                           newHeading.magneticHeading,
                           newHeading.trueHeading,
                           newHeading.headingAccuracy,
                           newHeading.timestamp,
                           newHeading.description,
                           newHeading.x,
                           newHeading.y,
                           newHeading.z];
    
}

/*
 *  locationManager:shouldDisplayHeadingCalibrationForDuration:
 *
 *  Discussion:
 *    Invoked when a new heading is available. Return YES to display heading calibration info. The display 
 *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
 */
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager  __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    NSLog(@"ShouldDisplayHeadingCalibration\n");
    return YES;
    
}

/*
 *  locationManager:didEnterRegion:
 *
 *  Discussion:
 *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0){
    
}

/*
 *  locationManager:didExitRegion:
 *
 *  Discussion:
 *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0){
    
}

/*
 *  locationManager:didFailWithError:
 *  
 *  Discussion:
 *    Invoked when an error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"error:%@\n",error);
    
}

/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *  
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0){
    
}

/*
 *  locationManager:didChangeAuthorizationStatus:
 *  
 *  Discussion:
 *    Invoked when the authorization status changes for this application.
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2){
    
}

/*
 *  locationManager:didStartMonitoringForRegion:
 *  
 *  Discussion:
 *    Invoked when a monitoring for a region started successfully.
 */
- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_TBD,__IPHONE_5_0){
    
}

- (void)dealloc {
    [self.locationManager stopUpdatingLocation];
    [textShow release];
    [lableShow release];
    [super dealloc];
}
@end
