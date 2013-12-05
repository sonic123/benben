//
//  SLDetailViewController.m
//  benben
//
//  Created by Sonic Lin on 12/3/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLDetailViewController.h"
#import "SLDetailViewMapCell.h"
#import "SLDetailViewNavigatorCell.h"
#import "SLSearchBusListViewController.h"

static NSString *detailViewMapCellID = @"SLDetailViewMapCell";
static NSString *detailViewNavigatorCellID = @"SLDetailViewNavigatorCell";

@interface SLDetailViewController ()

@end

@implementation SLDetailViewController
@synthesize tableView;
@synthesize dataModel;
@synthesize busListController;

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
    [self.tableView registerClass:[SLDetailViewMapCell class] forCellReuseIdentifier:detailViewMapCellID];
    [self.tableView registerClass:[SLDetailViewNavigatorCell class] forCellReuseIdentifier:detailViewNavigatorCellID];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=[NSString stringWithFormat:@"%@",self.dataModel.name];
    titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:20];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    titleLabel=nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITabLeViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 133;
            break;
        case 1:
            return 44;
            break;
        default:
            return 44;
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            SLDetailViewMapCell *cell=[self.tableView dequeueReusableCellWithIdentifier:detailViewMapCellID];
            if (!cell) {
                cell=[[SLDetailViewMapCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:detailViewMapCellID];
            }
            cell.dataModel=self.dataModel;
            cell.backgroundColor=[UIColor clearColor];
            [cell retrieveCoordinate];
            return cell;
        }
            break;
        case 1:
        {
            SLDetailViewNavigatorCell *cell=[self.tableView dequeueReusableCellWithIdentifier:detailViewNavigatorCellID];
            if (!cell) {
                cell=[[SLDetailViewNavigatorCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:detailViewNavigatorCellID];
                
            }
            cell.delegate=self;
            cell.dataModel=self.dataModel;
            cell.backgroundColor=[UIColor clearColor];

            return cell;
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark -
#pragma mark UITabLeViewDelegate

#pragma mark -
#pragma mark SLNavigatorDelegate
-(void)startBusSearch{
    if (!self.busListController) {
        self.busListController=[[SLSearchBusListViewController alloc]initWithNibName:@"SLSearchBusListViewController" bundle:nil];;
    }
    self.busListController.lat=self.dataModel.lat;
    self.busListController.lng=self.dataModel.lng;
    [self.navigationController pushViewController:self.busListController animated:YES];
}

@end
