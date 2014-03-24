//
//  Order.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 6.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "Order.h"

@implementation Order

- (NSDictionary *)hostToKinveyPropertyMapping
{
    
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    [mapping addEntriesFromDictionary:[super hostToKinveyPropertyMapping]];
    [mapping addEntriesFromDictionary:@{ @"currentSubscription" : @"currentSubscription" }];
    return mapping;
}

- (NSString *)statusDescription{
    
    switch ([self.currentSubscription integerValue]) {
        case 0:
            return @"Starter";
            break;
            
        case 1:
            return @"Indie";
            break;
            
        case 2:
            return @"Business";
            break;
            
        case 3:
            return @"Enterprise";
            break;
            
        default:
            return nil;
            break;
    }
}

@end
