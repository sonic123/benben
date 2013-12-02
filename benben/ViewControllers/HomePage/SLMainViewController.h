//
//  SLMainViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SLMainViewController : UIViewController
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


-(IBAction)actChooseCategory:(id)sender;


@end
