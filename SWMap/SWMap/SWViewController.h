//
//  SWViewController.h
//  SWMap
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-4.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SWLocation.h"

@interface SWViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate>{
    float ii;
    NSMutableArray *arrAnnotation;
}


//@property (retain, nonatomic) IBOutlet UITabBarController *tabbarController;
@property (retain, nonatomic) IBOutlet MKMapView *myMap;
@property (retain, nonatomic) IBOutlet UIToolbar *Test;
@property (retain, nonatomic) MKReverseGeocoder *geocoder;
@property (retain, nonatomic) SWLocation *locationView;
@property (retain, nonatomic) IBOutlet UIView *showView1;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;


@property (retain, nonatomic) IBOutlet MKMapView *libMapView;


- (void)gotoLocation:(CLLocationCoordinate2D)location;
- (IBAction)actionAddAnnotation:(id)sender;
- (IBAction)actionDelete:(id)sender;
- (IBAction)actionMapRec:(id)sender;
- (IBAction)actionSW:(id)sender;
- (IBAction)actionVisibleRect:(id)sender;
- (IBAction)actionSelectAnnotation:(id)sender;
- (IBAction)actionTrackingMode:(id)sender;
- (IBAction)actionAnnotationsInMapRect:(id)sender;
- (IBAction)actionAddLocationView:(id)sender;
- (IBAction)actionShowLocation:(id)sender;
- (IBAction)actionAddAnnotationOfAnimation:(id)sender;


- (IBAction)actionScrollView:(id)sender;


@end


//@interface SWAnnotation <MKAnnotation>
//
//@end