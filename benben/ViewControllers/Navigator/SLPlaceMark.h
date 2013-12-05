//
//  SLPlaceMark.h
//  benben
//
//  Created by Sonic Lin on 12/5/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SLPlace.h"

@interface SLPlaceMark : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) SLPlace* place;

-(id) initWithPlace: (SLPlace*) p;
@end
