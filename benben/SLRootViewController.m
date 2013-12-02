//
//  SLRootViewController.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLRootViewController.h"
#import "MBProgressHUD.h"
#import "RNFrostedSidebar.h"
#import "SLFoodController.h"
#import "SLMovieController.h"
#import "SLAppDelegate.h"

@interface SLRootViewController ()<MBProgressHUDDelegate,RNFrostedSidebarDelegate>
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation SLRootViewController

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
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Interface
- (void)showHudOnView:(UIView*)aView withTitle:(NSString*)aTitle
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:aView];
        [aView addSubview:_hud];
        _hud.delegate = self;
        _hud.minSize = CGSizeMake(135.f, 135.f);
    }
    else {
        _hud.alpha = 1.0f;
    }
	
    if (aTitle) {
        _hud.labelText = aTitle;
    }
    else {
        _hud.labelText = @"";
    }
    
    [_hud show:YES];
}

- (void)changeHudTitle:(NSString*)aNewTitle;
{
    if (_hud) {
        if (aNewTitle) {
            _hud.labelText = aNewTitle;
        }
        else {
            _hud.labelText = @"";
        }
    }
}

- (void)changeHudToCustomViewMode:(NSString*)aTitle
                        withImage:(NSString*)imgName
           hideAfterTimeIntervals:(NSTimeInterval)timeDelay
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_hud];
        _hud.delegate = self;
        _hud.minSize = CGSizeMake(135.f, 135.f);
    }
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
	_hud.mode = MBProgressHUDModeCustomView;
    
    if (aTitle) {
        _hud.labelText = aTitle;
    }
    else {
        _hud.labelText = nil;
    }
    
    [self hideAfterTimeIntervals:timeDelay];
}

- (void)hideAfterTimeIntervals:(NSTimeInterval)timeDelay {
    if (_hud) {
        [_hud hide:YES afterDelay:timeDelay];
    }
}
#pragma mark -
#pragma mark - RNFrostedSidebarDelegate
-(void)showMenu{
    if (!self.frostedSideBar) {
        NSArray *images = @[
                            [UIImage imageNamed:@"icon_homepage_foodCategory"],
                            [UIImage imageNamed:@"icon_homepage_movieCategory"],
                            [UIImage imageNamed:@"icon_homepage_hotelCategory"],
                            [UIImage imageNamed:@"icon_homepage_KTVCategory"],
                            [UIImage imageNamed:@"icon_homepage_entertainmentCategory"],
                            [UIImage imageNamed:@"icon_homepage_masageCategory"],
                            ];
        NSArray *colors = @[
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            ];
        self.frostedSideBar=[[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
        self.frostedSideBar.delegate = self;
        self.frostedSideBar.showFromRight = YES;
    }
    [self.frostedSideBar show];
}
-(void)goBack{
    NSArray *currentControllers=self.navigationController.viewControllers;
    NSMutableArray *newControllers=[NSMutableArray arrayWithArray:currentControllers];
    [newControllers removeLastObject];
    [self.navigationController setViewControllers:newControllers animated:YES];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSArray *currentControllers=self.navigationController.viewControllers;
    NSMutableArray *newControllers=[NSMutableArray arrayWithArray:currentControllers];
    [newControllers removeObjectAtIndex:1];
    if (index == 0) {
        if (!self.foodController) {
            self.foodController=[[SLFoodController alloc]initWithNibName:@"SLFoodController" bundle:nil];
        }
        [newControllers addObject:self.foodController];
    }
    if (index == 1) {
        if (!self.movieController) {
             self.movieController=[[SLMovieController alloc]initWithNibName:@"SLMovieController" bundle:nil];
        }
        [newControllers addObject:self.movieController];
    }
    [self.navigationController setViewControllers:newControllers animated:NO];
    [sidebar dismiss];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}


#pragma mark -
#pragma mark Appdelegate
-(SLAppDelegate *)getApplegate{
    return [[UIApplication sharedApplication]delegate];
}

@end
