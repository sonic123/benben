//
//  SLRootViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"
@class MBProgressHUD;
@class SLMovieController;
@class SLFoodController;
@class RNFrostedSidebar;
@interface SLRootViewController : UIViewController{
    MBProgressHUD *_hud;
}
@property (strong, nonatomic) RNFrostedSidebar *frostedSideBar;
@property (strong, nonatomic) SLFoodController *foodController;
@property (strong, nonatomic) SLMovieController *movieController;

- (void)showHudOnView:(UIView*)aView withTitle:(NSString*)aTitle;
- (void)changeHudTitle:(NSString*)aNewTitle;
- (void)changeHudToCustomViewMode:(NSString*)aTitle
                        withImage:(NSString*)imgName
           hideAfterTimeIntervals:(NSTimeInterval)timeDelay;
- (void)hideAfterTimeIntervals:(NSTimeInterval)timeDelay;

-(void)showMenu;
-(void)goBack;
@end
