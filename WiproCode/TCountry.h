//
//  TCountry.h
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIdentity.h"


extern NSString *const TCountryDidRefreshIdentity;

@interface TCountry : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray *identities;
@property (nonatomic, strong, readonly) NSCache *cache;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)identityDidDownloadImage:(TIdentity *)identity;

@end
