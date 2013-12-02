//
//  SLViewController.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLRootViewController.h"
#import "AibangApi.h"


@interface SLMovieController : SLRootViewController<UITableViewDataSource,UITableViewDataSource>{
    AibangApi *_aiBang;
}
@property (strong, nonatomic) NSMutableArray *cinemaArray;

@property (strong, nonatomic) IBOutlet UITableView *cinemaTable;
@end
