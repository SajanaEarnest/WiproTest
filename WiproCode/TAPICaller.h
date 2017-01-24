//
//  TAPICaller.h
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCountry.h"

extern NSString *const TAPICallerDidReceiveError;
extern NSString *const TAPICallerDidRefreshed;

extern NSUInteger const TAPIErrorCodeNullUrl;
extern NSUInteger const TAPIErrorCodeNullJSON;
extern NSString *const NSErrorDomainNullJSON;

@interface TAPICaller : NSObject

+(void)fetchData;

@end
