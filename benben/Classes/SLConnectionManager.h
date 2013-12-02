//
//  SLConnectionManager.h
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLConnectionDelegate;

@interface SLConnectionManager : NSObject
+(SLConnectionManager *)sharedManager;

@end

@protocol SLConnectionDelegate <NSObject>

@optional
- (void)PPRequest:(SLConnectionManager *)connection didLoadResponse:(id)dataResponse;
- (void)PPRequest:(SLConnectionManager *)connection didFailLoadWithError:(NSError*)error;
- (void)PPRequestDidCancelLoad:(SLConnectionManager *)connection;
- (void)PPRequestDidTimeout:(SLConnectionManager *)connection;

@end
