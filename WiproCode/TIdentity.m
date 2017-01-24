//
//  TIdentity.m
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//


#import "TIdentity.h"
#import "TCountry.h"

static NSString *TDefaultImageName = nil;//@"imageNotFound";

@interface TIdentity ()

@property (nonatomic, weak, readwrite) TCountry *country;
@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *descripion;
@property (nonatomic, strong, readwrite) NSString *imageHref;

@property (nonatomic, assign) BOOL isDownloading;

@end

@implementation TIdentity

BOOL _isValidDictionary(NSDictionary *dictionary) {
    //
    id title = dictionary[@"title"];
    id descripion = dictionary[@"description"];
    id imageHref = dictionary[@"imageHref"];
    //
    return ([title isKindOfClass:[NSString class]] || [descripion isKindOfClass:[NSString class]] || [imageHref isKindOfClass:[NSString class]]);
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary andCountry:(TCountry *)country {
    //
    if (_isValidDictionary(dictionary) == false) return nil;
    //
    self = [super init];
    if (self) {
        //
        id title = dictionary[@"title"];
        id descripion = dictionary[@"description"];
        id imageHref = dictionary[@"imageHref"];
        //
        if ([title isEqual:[NSNull null]]) title = nil;
        if ([descripion isEqual:[NSNull null]]) descripion = nil;
        if ([imageHref isEqual:[NSNull null]]) imageHref = nil;
        //
        self.title = title;
        self.descripion = descripion;
        self.imageHref = imageHref;
        self.country = country;
    }
    //
    return self;
}

-(UIImage *)_defaultImage {
    //
    return [UIImage imageNamed:TDefaultImageName];
}

-(UIImage *)_cachedImage {
    //
    NSCache *cache = _country.cache;
    if (!cache) return nil;
    //
    UIImage *image = [cache objectForKey:_imageHref];
    //
    return image;
}

-(BOOL)_cacheImage:(UIImage *)image {
    //
    NSCache *cache = _country.cache;
    if (!cache) return NO;
    //
    [cache setObject:image forKey:_imageHref];
    //
    return YES;
}

-(UIImage *)image {
    //
    if (_isDownloading) return [self _defaultImage];
    if (!_imageHref) return [self _defaultImage];
    //
    UIImage *image = [self _cachedImage];
    if (image) return image;
    //
    NSURL *url = [NSURL URLWithString:_imageHref];
    if (!url) return [self _defaultImage];
    //
    _isDownloading = YES;
    //
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0l), ^{
        //
        @autoreleasepool {
            //
            NSData *data = [NSData dataWithContentsOfURL:url];
            //
            if (data) {
                //
                UIImage *newImage = [UIImage imageWithData:data];
                //
                BOOL isCached = [self _cacheImage:newImage];
                //
                _isDownloading = NO;
                if (isCached) [_country identityDidDownloadImage:self];
            }
        }
    });
    //
    return [self _defaultImage];
}

@end











