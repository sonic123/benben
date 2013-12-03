//
//  SLRootViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"
#import "SLAppDelegate.h"

@class MBProgressHUD;
@class SLFoodController,SLMovieController,SLBarController,SLHotelsController,SLKTVController,SLPedicureController;
@class RNFrostedSidebar;
@interface SLRootViewController : UIViewController{
    MBProgressHUD *_hud;
}
@property (strong, nonatomic) RNFrostedSidebar *frostedSideBar;
@property (strong, nonatomic) SLFoodController *foodController;
@property (strong, nonatomic) SLHotelsController *hotelsController;
@property (strong, nonatomic) SLMovieController *movieController;
@property (strong, nonatomic) SLBarController *barController;
@property (strong, nonatomic) SLKTVController *ktvController;
@property (strong, nonatomic) SLPedicureController *pedicureController;

//
- (void)showHudOnView:(UIView*)aView withTitle:(NSString*)aTitle;
- (void)changeHudTitle:(NSString*)aNewTitle;
- (void)changeHudToCustomViewMode:(NSString*)aTitle
                        withImage:(NSString*)imgName
           hideAfterTimeIntervals:(NSTimeInterval)timeDelay;
- (void)hideAfterTimeIntervals:(NSTimeInterval)timeDelay;
//
-(SLAppDelegate *)getApplegate;
//
-(void)showMenu;
-(void)goBack;

@end
