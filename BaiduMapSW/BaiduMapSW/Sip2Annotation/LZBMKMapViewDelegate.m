//
//  LZBMKMapViewDelegate.m
//  BaiduMapSW
//
//  Created by shaowei on 13-1-4.
//  Copyright (c) 2013年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "LZBMKMapViewDelegate.h"


@implementation LZBMKMapViewDelegate

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - map-标注
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
        
        pin.canShowCallout = NO;
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

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    DLog(@"选中标注");
    //CGPoint point = [mapView convertCoordinate:view.annotation.coordinate toPointToView:mapView];
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
#ifdef Debug
        CGPoint point = [mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
        //CGRect rect = selectedAV.frame;
        DLog(@"annotationPoint:x=%.1f, y=%.1f class:%@", point.x, point.y,NSStringFromClass([selectedAV.superview class]));
#endif
        selectedAV = view;
//        if (bubbleView.superview == nil) {
//			//bubbleView加在BMKAnnotationView的superview(UIScrollView)上,且令zPosition为1
//            [view.superview addSubview:bubbleView];
//            bubbleView.layer.zPosition = 1;
//        }
//        bubbleView.infoDict = [dataArray objectAtIndex:[(KYPointAnnotation*)view.annotation tag]];
        //[self showBubble:YES];先移动地图，完成后再显示气泡
    }
    else {
        selectedAV = nil;
    }
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    DLog(@"取消选中标注");
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        [self showBubble:NO];
    }
}

#pragma mark map-区域改变
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (selectedAV) {
#ifdef Debug
        CGPoint point = [mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
        //CGRect rect = selectedAV.frame;
        DLog(@"x=%.1f, y= %.1f", point.x, point.y);
#endif
    }
    DLog(@"地图区域即将改变");
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (selectedAV) {
        [self showBubble:YES];
        [self changeBubblePosition];
        
        
#ifdef Debug
        CGPoint point = [mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
        DLog(@"x=%.1f, y= %.1f", point.x, point.y);
#endif
    }
    DLog(@"地图区域改变完成");
}

#pragma mark map-定位相关

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView{
    NSLog(@"sw-2- delegate 开始定位\n");
    
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    //    [mapView setZoomLevel:16];
    NSLog(@"sw-2- delegate 更新位置：%d\n",mapView.zoomLevel);
    if (!mapView.userLocationVisible) {
        NSLog(@"sw-2- sip2 delegate 显示-更新位置\n");
        [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
        
        //        [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        
    }
}

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    DLog(@"定位错误%@",error);
    
    [mapView setShowsUserLocation:NO];
    
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

#pragma mark 弹出Bubble操作
- (void)showBubble:(BOOL)show{
    
}



@end
