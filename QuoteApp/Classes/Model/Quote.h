//
//  Quote.h
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

#import <Foundation/Foundation.h>
#import "Product.h"

#define QUOTES_COLLECTIONS_NAME @"Quotes"

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


//Return name string type field of Quote collection
+ (NSArray *)textFieldsName;

@end
