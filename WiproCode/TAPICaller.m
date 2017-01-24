//
//  TAPICaller.m
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//


#import "TAPICaller.h"

NSString *const TAPICallerDidReceiveError = @"TCountryNotificationDidFaild";
NSString *const TAPICallerDidRefreshed = @"TCountryNotificationDidRefreshed";

NSUInteger const TAPIErrorCodeNullUrl = -11;
NSUInteger const TAPIErrorCodeNullJSON = -12;
NSString *const NSErrorDomainNullJSON = @"NULL JSON";


@implementation TAPICaller

+(void)fetchData {
    //
    NSString *urlString = @"https://dl.dropboxusercontent.com/u/746330/facts.json";
    //
    [self _downloadJSONFromURL:[NSURL URLWithString:urlString] withCompletion:^(NSDictionary *distionary, NSError *error) {
        //
        if (error == nil) {
            //
            id obj = [[TCountry alloc] initWithDictionary:distionary];
            [[NSNotificationCenter defaultCenter] postNotificationName:TAPICallerDidRefreshed object:obj];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:TAPICallerDidReceiveError object:error];
        }
    }];
}


+(void)_downloadJSONFromURL:(NSURL *)url withCompletion:(void (^)(NSDictionary *, NSError *))completion {
    //
    if (!url) {
        completion(nil, [NSError errorWithDomain:NSURLErrorDomain code:TAPIErrorCodeNullUrl userInfo:nil]);
        return;
    }
    //
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0l), ^{
        @autoreleasepool {
            //
            NSError *error;
            NSString *string = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:&error];
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //
            if (error == nil) {
                //
                id obj = [self _makeDistionaryFromData:data];
                if ([obj isKindOfClass:[NSDictionary class]]) completion(obj, nil);
                else completion(nil, obj);
            } else {
                //
                completion(nil, [NSError errorWithDomain:NSURLErrorDomain code:TAPIErrorCodeNullUrl userInfo:nil]);
            }
        }
    });
}

+(id)_makeDistionaryFromData:(NSData *)data {
    //
    NSError *error = nil;
    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&error];
    //
    if (error == nil) {
        //
        if (json) return json;
        else return [NSError errorWithDomain:NSErrorDomainNullJSON code:TAPIErrorCodeNullJSON userInfo:nil];
    }
    //
    return error;
}


@end
