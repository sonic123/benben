//
//  SLViewController.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLHotelsController.h"
#import "AibangApi.h"
#import "SLMerchantsDM.h"
#import "SLMerchantCell.h"
#import "UIImageView+WebCache.h"
#import "SLDetailViewController.h"


static NSString *MerchantCellIdentifier = @"MerchantCellIdentifier";

@interface SLHotelsController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic) int fromNumber;
@property (nonatomic) int toNumber;
@end

@implementation SLHotelsController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _fromNumber=1;
        _toNumber=10;
        
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
    self.hotelsArray=[NSMutableArray arrayWithCapacity:0];
    [self.hotelsTable registerClass:[SLMerchantCell class] forCellReuseIdentifier:MerchantCellIdentifier];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, 100, 30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=@"酒    店";
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
    if ([self.hotelsArray count]==0) {
        [self loadData];
    }
    
}
-(void)loadData{
    [super showHudOnView:self.view withTitle:@"加载中"];
    SLAppDelegate *delegate=[super getApplegate];
    if (delegate.lat||delegate.lng) {
       [_aiBang searchBizWithCity:@"上海" Query:@"酒店" Address:@"" Category:@"" Lng:[NSString stringWithFormat:@"%f",delegate.lng] Lat:[NSString stringWithFormat:@"%f",delegate.lat] Radius:@"5000" Rankcode:@"0" From:[NSString stringWithFormat:@"%d",_fromNumber] To:[NSString stringWithFormat:@"%d",_toNumber]];
    }else{
        [_aiBang searchBizWithCity:@"上海" Query:@"酒店" Address:@"" Category:@"" Lng:@"121.598105" Lat:@"31.211067" Radius:@"5000" Rankcode:@"0" From:[NSString stringWithFormat:@"%d",_fromNumber] To:[NSString stringWithFormat:@"%d",_toNumber]];
    }
    delegate=nil;
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
    
    if ([SLMerchantsDM parseIntoMerchantstList:self.hotelsArray fromString:data]) {
        [super changeHudToCustomViewMode:@"success" withImage:@"37x-CheckMark.png" hideAfterTimeIntervals:1];
        [self.hotelsTable reloadData];
    }else{
        [super changeHudToCustomViewMode:@"parse fail" withImage:@"37x-CheckMark.png" hideAfterTimeIntervals:1];
    }
    
}
-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi{
    [super changeHudToCustomViewMode:@"fail" withImage:@"37-Checkerror.png" hideAfterTimeIntervals:1];
}
#pragma mark -
#pragma mark UITableView Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.detailView) {
        self.detailView=[[SLDetailViewController alloc]initWithNibName:@"SLDetailViewController" bundle:nil];
        
    }
    self.detailView.dataModel=[self.hotelsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailView animated:YES];
    
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
    if ([self.hotelsArray count]!=0) {
        num=[self.hotelsArray count];
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLMerchantCell *cell=[self.hotelsTable dequeueReusableCellWithIdentifier:MerchantCellIdentifier];
    if (!cell) {
        cell=[[SLMerchantCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MerchantCellIdentifier];
    }
    
    SLMerchantsDM *oneMerchantDM=[self.hotelsArray objectAtIndex:indexPath.row];
    [cell.merchantAvator setImageWithURL:[NSURL URLWithString:oneMerchantDM.img_url] placeholderImage:[UIImage imageNamed:@"MerchantsImg.png"]];
    cell.merchantName.text=oneMerchantDM.name;
    cell.merchantCost.text=[NSString stringWithFormat:@"人均:%@",oneMerchantDM.cost];
    cell.merchantCate.text=oneMerchantDM.cate;
    double score=[oneMerchantDM.rate doubleValue];
    BOOL hasHalf;
    if (score /2==0.5||score /2==1.5||score /2==2.5 ) {
        hasHalf=YES;
    }else{
        hasHalf=NO;
    }
    [cell showRateScore:[oneMerchantDM.rate integerValue] withHalf:hasHalf];
    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
