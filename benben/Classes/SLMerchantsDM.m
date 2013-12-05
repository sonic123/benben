//
//  SLMerchantsDM.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLMerchantsDM.h"

@implementation SLMerchantsDM
@synthesize addr;
@synthesize cate;
@synthesize cost;
@synthesize desc;
@synthesize dist;
@synthesize merchantId;
@synthesize img_url;
@synthesize lat;
@synthesize lng;
@synthesize name;
@synthesize rate;
@synthesize tel;

+ (BOOL)parseIntoMerchantstList:(NSMutableArray*)merchantList
                     fromString:(NSData*)responseData
{
    if (!merchantList ||!responseData) {
        NSLog(@"Param Failed");
        return NO;
    }
    NSError *parseErr=nil;
    id objTmp=nil;
    NSDictionary *dicTmp=nil;
    NSArray *arrTmp=nil;
    do {
        id dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&parseErr];
        if (!dic || parseErr) {
            return NO;
        }
        objTmp=[dic objectForKey:@"bizs"];
        if (objTmp &&[objTmp isKindOfClass:[NSDictionary class]]) {
            dicTmp=(NSDictionary *)objTmp;
            if (dicTmp) {
                objTmp=[dicTmp objectForKey:@"biz"];
                if (objTmp &&[objTmp isKindOfClass:[NSArray class]]) {
                    arrTmp=(NSArray *)objTmp;
                }else{
                    objTmp=nil;
                }
            }else{
                dicTmp=nil;
            }
        }else{
            objTmp=nil;
        }
        SLMerchantsDM *oneMerchantsDM=nil;
        
        for (NSDictionary *dic in arrTmp) {
            @autoreleasepool {
                oneMerchantsDM=[[SLMerchantsDM alloc]init];
                oneMerchantsDM.addr=[dic objectForKey:@"addr"];
                oneMerchantsDM.cate=[dic objectForKey:@"cate"];
                oneMerchantsDM.cost=[dic objectForKey:@"cost"];
                oneMerchantsDM.desc=[dic objectForKey:@"desc"];
                oneMerchantsDM.dist=[dic objectForKey:@"dist"];
                oneMerchantsDM.merchantId=[dic objectForKey:@"id"];
                oneMerchantsDM.img_url=[dic objectForKey:@"img_url"];
                oneMerchantsDM.lat=[dic objectForKey:@"lat"];
                oneMerchantsDM.lng=[dic objectForKey:@"lng"];
                oneMerchantsDM.name=[dic objectForKey:@"name"];
                oneMerchantsDM.rate=[dic objectForKey:@"rate"];
                oneMerchantsDM.tel=[dic objectForKey:@"tel"];
                [merchantList addObject:oneMerchantsDM];
            }
        }
        
    } while (0);
    return YES;
}

@end
