//
//  SLNavigatorViewController.m
//  benben
//
//  Created by Sonic Lin on 12/5/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLNavigatorViewController.h"
#import "RegexKitLite.h"
#import "SLAppDelegate.h"

@interface SLNavigatorViewController ()

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded;
-(void) updateRouteView;
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
-(void) centerMap;

@end

@implementation SLNavigatorViewController

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
//    [self.navigationController setNavigationBarHidden:YES];
 
    UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"lottery_close@2x"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(actGoBack) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame=CGRectMake(20, 20, 33, 33);
    [self.mapView addSubview:closeBtn];
    closeBtn=nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.dateModel) {

        self.routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.mapView.frame.size.width, self.mapView.frame.size.height)];
        self.routeView.userInteractionEnabled = NO;
        [self.mapView addSubview:self.routeView];
        self.lineColor=[UIColor greenColor];
        
        SLAppDelegate *delegate=[super getApplegate];
        SLPlace *myPlace=[[SLPlace alloc]init];
//        myPlace.latitude=delegate.lat;
//        myPlace.longitude=delegate.lng;
        myPlace.latitude=31.211067;
        myPlace.longitude=121.598105;
        
        SLPlace *destination=[[SLPlace alloc]init];
        destination.latitude=[self.dateModel.lat doubleValue];
        destination.longitude=[self.dateModel.lng doubleValue];
        destination.name=self.dateModel.name;
        destination.description=[NSString stringWithFormat:@"电话：%@",self.dateModel.tel];

        
        [self showRouteFrom:myPlace To:destination];
        
        delegate=nil;
        myPlace=nil;
        destination=nil;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.routeView removeFromSuperview];
    self.routeView=nil;
    [super viewDidDisappear:animated];
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:0] ;
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5] ;
		NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
		printf("[%f,", [latitude doubleValue]);
		printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
		[array addObject:loc];
        latitude=nil;
        longitude=nil;
        loc=nil;
	}
	
	return array;
}

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t {
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
	NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
	NSLog(@"api url: %@", apiUrl);
    NSError *error=nil;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:&error];
	NSString* encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
	
	return [self decodePolyLine:[encodedPoints mutableCopy]];
}

-(void) centerMap {
	MKCoordinateRegion region;
    
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
	for(int idx = 0; idx < self.routes.count; idx++)
	{
		CLLocation* currentLocation = [self.routes objectAtIndex:idx];
		if(currentLocation.coordinate.latitude > maxLat)
			maxLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.latitude < minLat)
			minLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.longitude > maxLon)
			maxLon = currentLocation.coordinate.longitude;
		if(currentLocation.coordinate.longitude < minLon)
			minLon = currentLocation.coordinate.longitude;
	}
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
	
	[self.mapView setRegion:region animated:YES];
}
-(void) showRouteFrom: (SLPlace*) startPlace To:(SLPlace*) endPlace {
	
	if(self.routes) {
		[self.mapView removeAnnotations:[self.mapView annotations]];
		self.routes=nil;
	}
	
	SLPlaceMark* from = [[SLPlaceMark alloc] initWithPlace:startPlace];
	SLPlaceMark* to = [[SLPlaceMark alloc] initWithPlace:endPlace];
	
	[self.mapView addAnnotation:from];
	[self.mapView addAnnotation:to];
	
	self.routes = [self calculateRoutesFrom:from.coordinate to:to.coordinate];
	
	[self updateRouteView];
	[self centerMap];
}

-(void) updateRouteView {
    CGContextRef context = 	CGBitmapContextCreate(nil,
												  self.routeView.frame.size.width,
												  self.routeView.frame.size.height,
												  8,
												  8* self.routeView.frame.size.width,
												  CGColorSpaceCreateDeviceRGB(),
												  kCGImageAlphaPremultipliedLast);
    
	
	CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	
	for(int i = 0; i < self.routes.count; i++) {
		CLLocation* location = [self.routes objectAtIndex:i];
		CGPoint point = [self.mapView convertCoordinate:location.coordinate toPointToView:self.routeView];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, self.routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, self.routeView.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	self.routeView.image = img;
//    NSArray *subViews=[self.view subviews];
//    [self.mapView bringSubviewToFront:self.routeView];
	CGContextRelease(context);
    
}
-(void)actGoBack{
    NSArray *currentControllers=self.navigationController.viewControllers;
    NSMutableArray *newControllers=[NSMutableArray arrayWithArray:currentControllers];
    [newControllers removeLastObject];
    [self.navigationController setViewControllers:newControllers animated:YES];
}

#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	self.routeView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

	[self updateRouteView];
	self.routeView.hidden = NO;
	[self.routeView setNeedsDisplay];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
