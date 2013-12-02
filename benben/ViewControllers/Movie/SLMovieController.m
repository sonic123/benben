//
//  SLViewController.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLMovieController.h"
#import "AibangApi.h"
#import "SLMerchantsDM.h"
#import "SLMerchantCell.h"
#import "UIImageView+WebCache.h"


static NSString *MerchantCellIdentifier = @"MerchantCellIdentifier";

@interface SLMovieController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation SLMovieController


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
	// Do any additional setup after loading the view, typically from a nib.
    if (!_aiBang) {
        _aiBang=[[AibangApi alloc]init];
        _aiBang.delegate=self;
    }
    self.cinemaArray=[NSMutableArray arrayWithCapacity:0];
    [self.cinemaTable registerClass:[SLMerchantCell class] forCellReuseIdentifier:MerchantCellIdentifier];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=@"影    院";
    titleLabel.font=[UIFont fontWithName:@"Avenir-Light" size:20];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLabel;
    titleLabel=nil;
    UIBarButtonItem *rightButtom=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    UIBarButtonItem *leftButtom=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_dealsmap_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem=rightButtom;
    self.navigationItem.leftBarButtonItem=leftButtom;
    rightButtom=nil;
    leftButtom=nil;
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super showHudOnView:self.view withTitle:@"加载中"];
    [_aiBang searchBizWithCity:@"北京" Query:@"影院" Address:@"" Category:@"" Lng:@"116.420038" Lat:@"39.908568" Radius:@"5000" Rankcode:@"0" From:@"1" To:@"10"];
}
-(void)showMenu{
    [super showMenu];
}
-(void)goBack{
    [super goBack];
}
#pragma mark -
#pragma mark AibangApiDelegate
-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi{
    
    if ([SLMerchantsDM parseIntoMerchantstList:self.cinemaArray fromString:data]) {
        NSLog(@"%@",self.cinemaArray);
        [super changeHudToCustomViewMode:@"success" withImage:@"37x-CheckMark" hideAfterTimeIntervals:1];
        [self.cinemaTable reloadData];
    }else{
        [super changeHudToCustomViewMode:@"parse fail" withImage:@"37x-CheckMark" hideAfterTimeIntervals:1];
    }
    
}
-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi{
    [super changeHudToCustomViewMode:@"fail" withImage:@"37-Checkerror" hideAfterTimeIntervals:1];
}
#pragma mark -
#pragma mark UITableView Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger num=0;
    if ([self.cinemaArray count]!=0) {
        num=[self.cinemaArray count];
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLMerchantCell *cell=[self.cinemaTable dequeueReusableCellWithIdentifier:MerchantCellIdentifier];
    if (!cell) {
        cell=[[SLMerchantCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MerchantCellIdentifier];
    }
    
    SLMerchantsDM *oneMerchantDM=[self.cinemaArray objectAtIndex:indexPath.row];
    [cell.merchantAvator setImageWithURL:[NSURL URLWithString:oneMerchantDM.img_url] placeholderImage:[UIImage imageNamed:@""]];
    cell.merchantName.text=oneMerchantDM.name;
    cell.merchantCost.text=[NSString stringWithFormat:@"人均:%@",oneMerchantDM.cost];
    cell.merchantCate.text=oneMerchantDM.cate;
    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
