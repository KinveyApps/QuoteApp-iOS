//
//  Order.h
//  QuoteApp
//
//  Created by Igor Sapyanik on 6.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"

@interface Order : Quote

@property (nonatomic, retain) NSNumber *currentSubscription;

- (NSString *)statusDescription;

@end
