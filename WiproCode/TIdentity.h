//
//  TIdentity.h
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TCountry;
@interface TIdentity : NSObject

@property (nonatomic, weak, readonly) TCountry *country;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSString *descripion;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary andCountry:(TCountry *)country;

@end

