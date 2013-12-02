//
//  SLMainViewController.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLFoodController.h"
#import "SLMovieController.h"
#import "SLAppDelegate.h"


static NSString *HomePageCellIdentifier = @"HomePageCellIdentifier";

@interface SLMainViewController ()

@end



@implementation SLMainViewController

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
    [self initLocation];
    [self initUI];
}
-(void)initLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        if (!self.locationManager) {
            self.locationManager=[[CLLocationManager alloc]init];
            self.locationManager.delegate=self;
            self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            self.locationManager.distanceFilter=1000.0f;
        }
        //启动位置更新
        [self.locationManager startUpdatingLocation];
    }else{
        UIAlertView *alterShow=[[UIAlertView alloc]initWithTitle:@"" message:@"定位服务不可用，请打开定位功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterShow show];
    }
}
-(void)initUI{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=@"笨   笨";
    titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:20];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    titleLabel=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)actChooseCategory:(id)sender{

    if ([sender isEqual:self.foodBtn]) {
        SLFoodController *foodController=[[SLFoodController alloc]initWithNibName:@"SLFoodController" bundle:nil];
        [self.navigationController pushViewController:foodController animated:YES];
        foodController=nil;
    }
    if([sender isEqual:self.movieBtn]){
        SLMovieController *movieController=[[SLMovieController alloc]initWithNibName:@"SLMovieController" bundle:nil];
        [self.navigationController pushViewController:movieController animated:YES];
        movieController=nil;
    }
}
#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    SLAppDelegate *delegate=[super getApplegate];
    delegate.lat=newLocation.coordinate.latitude;
    delegate.lng=newLocation.coordinate.longitude;
    delegate=nil;

    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
}



@end
