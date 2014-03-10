//
//  DataHelper.m
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import "DataHelper.h"

@interface DataHelper ()

@property (nonatomic, strong) KCSLinkedAppdataStore *quotesStore;
@property (nonatomic, strong) KCSLinkedAppdataStore *ordersStore;
@property (nonatomic, strong) KCSLinkedAppdataStore *productStore;
@property (nonatomic, strong) NSDictionary *contentTypesByName;

@end

@implementation DataHelper

@synthesize formatter = _formatter;

SYNTHESIZE_SINGLETON_FOR_CLASS(DataHelper)

- (id)init {
	self = [super init];
	if (self) {
        
        KCSCollection *collectionQuote = [KCSCollection collectionFromString:@"Quotes" ofClass:[Quote class]];
        self.quotesStore = [KCSLinkedAppdataStore storeWithOptions:@{ KCSStoreKeyResource : collectionQuote,
                                                                      KCSStoreKeyCachePolicy : @(KCSCachePolicyNetworkFirst)}];
        
        KCSCollection *collectionOrder = [KCSCollection collectionFromString:@"Orders" ofClass:[Order class]];
        self.ordersStore = [KCSLinkedAppdataStore storeWithOptions:@{ KCSStoreKeyResource : collectionOrder,
                                                                      KCSStoreKeyCachePolicy : @(KCSCachePolicyNetworkFirst)}];
        
        KCSCollection *collectionProduct = [KCSCollection collectionFromString:@"Products" ofClass:[Product class]];
        self.productStore = [KCSLinkedAppdataStore storeWithOptions:@{ KCSStoreKeyResource : collectionProduct,
                                                                      KCSStoreKeyCachePolicy : @(KCSCachePolicyNetworkFirst)}];
	}
	return self;
}

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [_formatter setDateFormat:FORMAT_DATE];
    }
    return _formatter;
}

- (NSString *)regexForContaintSubstring:(NSString *)substring{
    return [[@"^.{0,}" stringByAppendingString:substring] stringByAppendingString:@".{0,}"];
}

- (KCSQuery *)queryForOriginatorEqualsActiveUser{
    return [KCSQuery queryOnField:@"originator._id" withExactMatchForValue:[KCSUser activeUser].userId];
}

#pragma mark - QUOTE
#pragma mark - Save and Load Entity

- (void)loadQuotesUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    
    KCSQuery *query;
    
    if (substring.length) {
        query = [KCSQuery queryOnField:@"referenceNumber"
                             withRegex:[self regexForContaintSubstring:substring]];
        KCSQuery *alloyQuery = [KCSQuery queryOnField:@"alloy"
                                            withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:alloyQuery
                             usingOperator:kKCSOr];
        KCSQuery *finishQuery = [KCSQuery queryOnField:@"finish"
                                             withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:finishQuery
                             usingOperator:kKCSOr];
        KCSQuery *temperQuery = [KCSQuery queryOnField:@"temper"
                                             withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:temperQuery
                             usingOperator:kKCSOr];
    }else{
        query = [KCSQuery query];
    }
    [query addQueryForJoiningOperator:kKCSAnd onQueries:[self queryForOriginatorEqualsActiveUser], nil];
    
	[self.quotesStore queryWithQuery:query
                 withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        
                                if (!errorOrNil) {
                                    if (reportSuccess) reportSuccess([self entityWithActiveUserOriginatorOnArray:objectsOrNil]);
                                }else{
                                    if (reportFailure) reportFailure(errorOrNil);
                                }
                            }
                   withProgressBlock:nil
                         cachePolicy:useCache ? KCSCachePolicyLocalFirst : KCSCachePolicyNetworkFirst];
    
}

- (void)saveQuote:(Quote *)quote OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    
    [self.quotesStore saveObject:quote withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (errorOrNil != nil) {
            if (reportFailure) reportFailure(errorOrNil);
        } else {
            if (reportSuccess) reportSuccess(objectsOrNil);
        }
    } withProgressBlock:nil];
    
}

#pragma mark - ORDER
#pragma mark - Save and Load Entity

- (void)loadOrdersUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    
    KCSQuery *query;
    
    if (substring.length) {
        query = [KCSQuery queryOnField:@"referenceNumber"
                             withRegex:[self regexForContaintSubstring:substring]];
        KCSQuery *alloyQuery = [KCSQuery queryOnField:@"alloy"
                                            withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:alloyQuery
                             usingOperator:kKCSOr];
        KCSQuery *finishQuery = [KCSQuery queryOnField:@"finish"
                                             withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:finishQuery
                             usingOperator:kKCSOr];
        KCSQuery *temperQuery = [KCSQuery queryOnField:@"temper"
                                             withRegex:[self regexForContaintSubstring:substring]];
        query = [query queryByJoiningQuery:temperQuery
                             usingOperator:kKCSOr];
    }else{
        query = [KCSQuery query];
    }
    [query addQueryForJoiningOperator:kKCSAnd onQueries:[self queryForOriginatorEqualsActiveUser], nil];
    
    [self.ordersStore queryWithQuery:query
                 withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
                                        if (!errorOrNil) {
                                            if (reportSuccess) reportSuccess([self entityWithActiveUserOriginatorOnArray:objectsOrNil]);
                                        }else{
                                            if (reportFailure) reportFailure(errorOrNil);
                                        }
                                    }
                   withProgressBlock:nil
                         cachePolicy:useCache ? KCSCachePolicyLocalFirst : KCSCachePolicyNetworkFirst];
    
}

- (void)saveOrder:(Order *)order OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    
    [self.ordersStore saveObject:order withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (errorOrNil != nil) {
            if (reportFailure) reportFailure(errorOrNil);
        } else {
            if (reportSuccess) reportSuccess(objectsOrNil);
        }
    } withProgressBlock:nil];
    
}

#pragma mark - USER
#pragma mark - Save and Load Attributes

- (void)saveUserWithInfo:(NSDictionary *)userInfo OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    KCSUser *user = [KCSUser activeUser];
    if (user) {
        NSArray *keyArray = [self allUserInfoKey];
        for (int i = 0; i < keyArray.count; i++) {
            if (userInfo[keyArray[i]]) {
                [user setValue:userInfo[keyArray[i]] forAttribute:keyArray[i]];
            }
        }
        
        [user saveWithCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
            
            if (!errorOrNil) {
                if (reportSuccess) reportSuccess(objectsOrNil);
            }
            else {
                if (reportFailure) reportFailure(errorOrNil);
            }
            
        }];
    }
}

- (void)loadUserOnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    KCSUser *user = [KCSUser activeUser];
    [user refreshFromServer:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        
        if (!errorOrNil) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            NSArray *keyArray = [self allUserInfoKey];
            for (int i = 0; i < keyArray.count; i++) {
                if ([user getValueForAttribute:keyArray[i]]) {
                    userInfo[keyArray[i]] = [user getValueForAttribute:keyArray[i]];
                }
            }
            
            if (reportSuccess) reportSuccess(@[[userInfo copy]]);
        }
        else {
            if (reportFailure) reportFailure(errorOrNil);
        }
        
    }];
}

#pragma mark - Utils

- (NSArray *)allUserInfoKey{
    return @[USER_INFO_KEY_CONTACT,
             USER_INFO_KEY_COMPANY,
             USER_INFO_KEY_SHIPING_ADDRESS,
             USER_INFO_KEY_ACCOUNT_NUMBER,
             USER_INFO_KEY_PHONE
             ];
}

- (NSArray *)entityWithActiveUserOriginatorOnArray:(NSArray *)array{
    NSMutableArray *result = [NSMutableArray array];
    KCSUser *user = [KCSUser activeUser];
    for (int i = 0; i < array.count; i++) {
        Quote *quote = (Quote *)array[i];
        if ([quote.originator.userId isEqualToString:user.userId]) {
            [result addObject:quote];
        }
    }
    return result;
}

#pragma mark - PRODUCT
#pragma mark - Load

- (void)loadProductsUseCache:(BOOL)useCache containtSubstinrg:(NSString *)substring OnSuccess:(void (^)(NSArray *))reportSuccess onFailure:(STErrorBlock)reportFailure{
    
    KCSQuery *query;
    
    if (substring.length) {
        query = [KCSQuery queryOnField:@"title" withRegex:[self regexForContaintSubstring:substring]];
    }else{
        query = [KCSQuery query];
    }
    
    [self.productStore queryWithQuery:query
                  withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
                                        if (!errorOrNil) {
                                            if (reportSuccess) reportSuccess(objectsOrNil);
                                        }else{
                                            if (reportFailure) reportFailure(errorOrNil);
                                        }
                                    }
                    withProgressBlock:nil
                          cachePolicy:(useCache ? KCSCachePolicyLocalFirst : KCSCachePolicyNetworkFirst)];
}

@end
