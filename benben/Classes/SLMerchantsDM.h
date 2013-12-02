//
//  SLMerchantsDM.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMerchantsDM : NSObject
@property (strong, nonatomic) NSString *addr;
@property (strong, nonatomic) NSString *cate;
@property (strong, nonatomic) NSString *cost;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *dist;
@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *img_url;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *rate;
@property (strong, nonatomic) NSString *tel;

+ (BOOL)parseIntoMerchantstList:(NSMutableArray*)merchantList
                     fromString:(NSData*)responseData;

@end
