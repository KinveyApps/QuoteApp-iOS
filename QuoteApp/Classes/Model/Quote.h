//
//  Quote.h
//  QuoteApp
//
//  Created by Igor Sapyanik on 6.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

#define STARTER_ORDER_SUBSCRIPTION @0
#define INDIE_ORDER_SUBSCRIPTION @1
#define BUSINESS_ORDER_SUBSCRIPTION @2
#define ENTERPRISE_ORDER_SUBSCRIPTION @3

@interface Quote : NSObject

@property (nonatomic, retain) NSString *kinveyId;
@property (nonatomic, retain) KCSMetadata *meta;
@property (nonatomic, retain) NSString *referenceNumber;
@property (nonatomic, retain) KCSUser *originator;
@property (nonatomic, retain) NSString *activeUsers;
@property (nonatomic, retain) NSString *businessLogicScripts;
@property (nonatomic, retain) NSString *scheduledBusinessLogic;
@property (nonatomic, retain) NSString *collaborators;
@property (nonatomic, retain) NSString *backendEnvironments;
@property (nonatomic, retain) NSString *dataStorage;
@property (nonatomic, retain) NSString *businessLogicExecutionTimeLimit;
@property (nonatomic, retain) NSString *totalPrice;
@property (nonatomic, retain) NSDate *startSubscriptionDate;
@property (nonatomic, retain) Product *product;

@end
