//
//  DataHelper.h
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"
#import "Order.h"
#import "Product.h"

#define USER_INFO_KEY_CONTACT                   @"Contact"
#define USER_INFO_KEY_COMPANY                   @"Company"
#define USER_INFO_KEY_ACCOUNT_NUMBER            @"Account Number"
#define USER_INFO_KEY_PHONE                     @"Phone"
#define USER_INFO_KEY_EMAIL                     KCSUserAttributeEmail
#define USER_INFO_KEY_PUSH_NOTIFICATION_ENABLE  @"PushNotificationEnable"
#define USER_INFO_KEY_EMAIL_CONFIRMATION_ENABLE @"EmailConfirmationEnable"
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
