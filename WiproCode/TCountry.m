//
//  TCountry.m
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//

#import "TCountry.h"

NSString *const TCountryDidRefreshIdentity = @"TCountryDidRefreshIdentity";

@interface TCountry ()

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSArray *identities;
@property (nonatomic, strong, readwrite) NSCache *cache;

@end


@implementation TCountry

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    //
    self = [super init];
    if (self) {
        //
        NSArray *rows = dictionary[@"rows"];
        NSMutableArray *newRows = [NSMutableArray array];
        //
        for (NSDictionary *obj in rows) {
            //
            TIdentity *identity = [[TIdentity alloc] initWithDictionary:obj andCountry:self];
            if (identity) {
                [newRows addObject:identity];
            }
        }
        //
        self.title = dictionary[@"title"];
        self.identities = newRows;
    }
    //
    return self;
}

-(NSCache *)cache {
    //
    if (_cache) return _cache;
    //
    NSString *name = _title;
    if (name == nil) name = @"tempccsd";
    //
    NSCache *cache = [[NSCache alloc] init];
    [cache setName:name];
    //
    self.cache = cache;
    //
    return cache;
}

-(void)identityDidDownloadImage:(TIdentity *)identity {
    //
    NSUInteger index = [_identities indexOfObject:identity];
    //
    if (index != NSNotFound) {
        //
        NSDictionary *obj = @{@"identity" :self, @"index" : @(index) } ;
        [[NSNotificationCenter defaultCenter] postNotificationName:TCountryDidRefreshIdentity object:obj];
    }
}


@end

