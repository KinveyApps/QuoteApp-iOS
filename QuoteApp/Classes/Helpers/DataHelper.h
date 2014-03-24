//
//  DataHelper.h
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
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
#import "Quote.h"
#import "Order.h"
#import "Product.h"

//Define user attribute key
#define USER_INFO_KEY_CONTACT                   @"Contact"
#define USER_INFO_KEY_COMPANY                   @"Company"
#define USER_INFO_KEY_ACCOUNT_NUMBER            @"Account Number"
#define USER_INFO_KEY_PHONE                     @"Phone"
#define USER_INFO_KEY_EMAIL                     KCSUserAttributeEmail
#define USER_INFO_KEY_PUSH_NOTIFICATION_ENABLE  @"PushNotificationEnable"
#define USER_INFO_KEY_EMAIL_CONFIRMATION_ENABLE @"EmailConfirmationEnable"

//Define date format
#define FORMAT_DATE                             @"dd/MM/yyyy"


@interface DataHelper : NSObject

+ (DataHelper *)instance;

@property (strong, nonatomic) NSDateFormatter *formatter;

- (void)loadQuotesUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;
- (void)saveQuote:(Quote *)quote OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;

- (void)loadOrdersUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;
- (void)saveOrder:(Order *)order OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;

- (void)loadProductsUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;

- (void)saveUserWithInfo:(NSDictionary *)userInfo OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;
- (void)loadUserOnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure;

@end
