//
//  SLDetailViewMapCell.m
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLDetailViewMapCell.h"
#import "SLAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLDetailViewMapCell
@synthesize mapView;
@synthesize dataModel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
               
        self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(8, 12, 305, 110)];
        self.mapView.delegate=self;
        self.mapView.layer.cornerRadius=5.0f;
        self.mapView.layer.masksToBounds=YES;
        self.mapView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.mapView.layer.borderWidth=2.0f;
        [self.contentView addSubview:self.mapView];
        
        UIView *selectedView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 134)];
        selectedView.backgroundColor=[UIColor clearColor];
        self.selectedBackgroundView=selectedView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)retrieveCoordinate{
    CLLocationCoordinate2D coordinate={0};
    if (self.dataModel) {
        coordinate.latitude=[self.dataModel.lat doubleValue];
        coordinate.longitude=[self.dataModel.lng doubleValue];
    }else{
        SLAppDelegate *delegate=[[UIApplication sharedApplication]delegate];
        coordinate.latitude=delegate.lat;
        coordinate.longitude=delegate.lng;
        delegate=nil;
    }
    [self.mapView removeAnnotations:[self.mapView annotations]];
    MKPointAnnotation *annotation=nil;
    annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate=coordinate;
    annotation.title=self.dataModel.name;
    [self.mapView addAnnotation:annotation];
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);
    MKCoordinateRegion adjustedRegion=[self.mapView regionThatFits:region];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
}
#pragma mark -
#pragma mark MapView Annotation Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.sonicCode.pin";
    pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView )
    {
        pinView = [[MKPinAnnotationView alloc]
               initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.pinColor=MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        return pinView;
    }
    else{
        pinView.annotation=annotation;
    }
    return pinView;
}



@end
