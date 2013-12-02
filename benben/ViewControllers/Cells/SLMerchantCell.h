//
//  SLMerchantCell.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLMerchantCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *merchantAvator;
@property (strong, nonatomic) IBOutlet UILabel *merchantName;
@property (strong, nonatomic) IBOutlet UILabel *merchantCost;
@property (strong, nonatomic) IBOutlet UILabel *merchantCate;
@property (strong, nonatomic) IBOutlet UILabel *merchantDistance;
@property (strong, nonatomic) IBOutlet UIImageView *rateImageView1;
@property (strong, nonatomic) IBOutlet UIImageView *rateImageView2;
@property (strong, nonatomic) IBOutlet UIImageView *rateImageView3;
@property (strong, nonatomic) IBOutlet UIImageView *rateImageView4;
@property (strong, nonatomic) IBOutlet UIImageView *rateImageView5;

-(void)showRateScore:(NSInteger)score withHalf:(BOOL)hasHalf;

@end
