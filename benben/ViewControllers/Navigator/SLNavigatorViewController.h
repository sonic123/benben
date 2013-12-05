//
//  SLNavigatorViewController.h
//  benben
//
//  Created by Sonic Lin on 12/5/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SLRootViewController.h"
#import "SLPlace.h"
#import "SLPlaceMark.h"
#import "SLMerchantsDM.h"

@interface SLNavigatorViewController : SLRootViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) UIImageView *routeView;
@property (strong, nonatomic) NSArray *routes;
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) SLMerchantsDM *dateModel;
-(void)showRouteFrom:(SLPlace *)startPlace To:(SLPlace *)endPlace;
@end
