//
//  SLMainViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SLRootViewController.h"

@class SLFoodController,SLMovieController,SLBarController,SLHotelsController,SLKTVController,SLPedicureController;

@interface SLMainViewController : SLRootViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *foodBtn;
@property (strong, nonatomic) IBOutlet UILabel *foodLabel;
@property (strong, nonatomic) IBOutlet UIButton *movieBtn;
@property (strong, nonatomic) IBOutlet UILabel *movieLabel;
@property (strong, nonatomic) IBOutlet UIButton *hotelBtn;
@property (strong, nonatomic) IBOutlet UILabel *hotelLabel;
@property (strong, nonatomic) IBOutlet UIButton *ktvBtn;
@property (strong, nonatomic) IBOutlet UILabel *ktbLabel;
@property (strong, nonatomic) IBOutlet UIButton *barBtn;
@property (strong, nonatomic) IBOutlet UILabel *barLabel;
@property (strong, nonatomic) IBOutlet UIButton *pedicureBtn;
@property (strong, nonatomic) IBOutlet UILabel *pedicureLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) SLFoodController *foodController;
@property (strong, nonatomic) SLHotelsController *hotelsController;
@property (strong, nonatomic) SLMovieController *movieController;
@property (strong, nonatomic) SLBarController *barController;
@property (strong, nonatomic) SLKTVController *ktvController;
@property (strong, nonatomic) SLPedicureController *pedicureController;


-(IBAction)actChooseCategory:(id)sender;
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error ;

@end
