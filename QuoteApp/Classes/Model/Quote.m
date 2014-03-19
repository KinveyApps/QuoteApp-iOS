//
//  Quote.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 6.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "Quote.h"

@implementation Quote

- (NSDictionary *)hostToKinveyPropertyMapping
{
    return @{@"kinveyId"                        : KCSEntityKeyId,
			 @"meta"                            : KCSEntityKeyMetadata,
             @"originator"                      : @"originator",
             @"referenceNumber"                 : @"referenceNumber",
             @"activeUsers"                     : @"activeUsers",
             @"businessLogicScripts"            : @"businessLogicScripts",
             @"scheduledBusinessLogic"          : @"scheduledBusinessLogic",
             @"collaborators"                   : @"collaborators",
             @"backendEnvironments"             : @"backendEnvironments",
             @"dataStorage"                     : @"dataStorage",
             @"businessLogicExecutionTimeLimit" : @"businessLogicExecutionTimeLimit",
             @"totalPrice"                      : @"totalPrice",
             @"startSubscriptionDate"           : @"startSubscriptionDate",
             @"product"                         : @"product"};
}

+ (NSDictionary *)kinveyPropertyToCollectionMapping{
    return @{ @"originator" : KCSUserCollectionName,
              @"product" : @"Products"};
}

+ (NSDictionary *)kinveyObjectBuilderOptions{
    return @{ KCS_REFERENCE_MAP_KEY : @{ @"product" : [Product class]}};
}

+ (NSArray *)textFieldsName{
    return @[@"referenceNumber",
             @"activeUsers",
             @"businessLogicScripts",
             @"scheduledBusinessLogic",
             @"collaborators",
             @"backendEnvironments",
             @"dataStorage",
             @"businessLogicExecutionTimeLimit",
             @"totalPrice"];
}

@end
