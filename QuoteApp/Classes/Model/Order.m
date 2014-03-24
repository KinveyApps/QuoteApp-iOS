//
//  Order.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 6.2.14.
/**
 * Copyright (c) 2014 Kinvey Inc. *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at *
 * http://www.apache.org/licenses/LICENSE-2.0 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License. *
 */


#import "Order.h"

@implementation Order

- (NSDictionary *)hostToKinveyPropertyMapping
{
    //Kinvey: Mapping Function
    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    [mapping addEntriesFromDictionary:[super hostToKinveyPropertyMapping]];
    //                                  client property         : backend column
    //                                  ------------------------:-------------------------------
    [mapping addEntriesFromDictionary:@{ @"currentSubscription" : @"currentSubscription" }];    //currentSubscription maps to currentSubscription
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
