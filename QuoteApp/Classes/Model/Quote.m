//
//  Quote.m
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


#import "Quote.h"

@implementation Quote

- (NSDictionary *)hostToKinveyPropertyMapping
{
    //Kinvey: Mapping Function
    //      client property                     : backend column
    //      ------------------------------------:---------------------------------------
    return @{@"kinveyId"                        : KCSEntityKeyId,                       //kinveyId maps to _id
			 @"meta"                            : KCSEntityKeyMetadata,                 //meta maps to metadata
             @"originator"                      : @"originator",                        //originator maps to originator
             @"referenceNumber"                 : @"referenceNumber",                   //referenceNumber maps to referenceNumber
             @"activeUsers"                     : @"activeUsers",                       //activeUsers maps to activeUsers
             @"businessLogicScripts"            : @"businessLogicScripts",              //businessLogicScripts maps to businessLogicScripts
             @"scheduledBusinessLogic"          : @"scheduledBusinessLogic",            //scheduledBusinessLogic maps to scheduledBusinessLogic
             @"collaborators"                   : @"collaborators",                     //collaborators maps to collaborators
             @"backendEnvironments"             : @"backendEnvironments",               //backendEnvironments maps to backendEnvironments
             @"dataStorage"                     : @"dataStorage",                       //dataStorage maps to dataStorage
             @"businessLogicExecutionTimeLimit" : @"businessLogicExecutionTimeLimit",   //businessLogicExecutionTimeLimit maps to businessLogicExecutionTimeLimit
             @"totalPrice"                      : @"totalPrice",                        //totalPrice maps to totalPrice
             @"startSubscriptionDate"           : @"startSubscriptionDate",             //origistartSubscriptionDatenator maps to startSubscriptionDate
             @"product"                         : @"product"};                          //product maps to product
}

+ (NSDictionary *)kinveyPropertyToCollectionMapping{
    return @{ @"originator" : KCSUserCollectionName,
              @"product"    : @"Products"};
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
