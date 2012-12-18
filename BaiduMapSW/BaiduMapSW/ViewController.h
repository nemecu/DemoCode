//
//  ViewController.h
//  BaiduMapSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-5.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface ViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>{
    BMKMapView *mapView;
    BMKCircle *circleOverLayer;
    BOOL isMode;
    BOOL isLocation;
    
    //POI检索
    BMKSearch *POISearch;
    int poiPageIndex;
}
@property (retain, nonatomic) IBOutlet UIView *btnView;
@property (assign,nonatomic,getter = mmode) BOOL isMode;
@property (retain, nonatomic) IBOutlet UILabel *showStatus;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (retain, nonatomic) IBOutlet UIView *POIView;
@property (retain, nonatomic) IBOutlet UITextField *inputCity;
@property (retain, nonatomic) IBOutlet UITextField *inputKey;



//POI检索
- (IBAction)actionPOISearchWithCity:(id)sender;
- (IBAction)actionPOISearchBound:(id)sender;
- (IBAction)actionPOISearchNearBy:(id)sender;


- (IBAction)actionBusSearch:(id)sender;
- (IBAction)actionCarsearch:(id)sender;
- (IBAction)actionStepSearch:(id)sender;


//定位 action
- (IBAction)actionViewShow:(id)sender;
- (IBAction)actionViewHide:(id)sender;
- (IBAction)actionAddAnnotation:(id)sender;
- (IBAction)actionRemoveAnnotation:(id)sender;
- (IBAction)actionAddOverLayer:(id)sender;
- (IBAction)actionAddTriangle:(id)sender;
- (IBAction)actionAddcircle:(id)sender;
- (IBAction)removeOverLayer:(id)sender;
- (IBAction)actionZhiHuiGuan:(id)sender;
- (IBAction)actionZoomIn:(id)sender;
- (IBAction)actionZoomOut:(id)sender;
- (IBAction)actionChangeMode:(id)sender;
- (IBAction)actionStartLocation:(id)sender;








@end
