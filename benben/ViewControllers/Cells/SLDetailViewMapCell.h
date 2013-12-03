//
//  SLDetailViewMapCell.h
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SLMerchantsDM.h"

@interface SLDetailViewMapCell : UITableViewCell<MKMapViewDelegate>


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) SLMerchantsDM *dataModel;


-(void)retrieveCoordinate;

@end
