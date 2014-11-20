//
//  Product.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.2.14.
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


#import "Product.h"

@implementation Product

- (NSDictionary *)hostToKinveyPropertyMapping
{
    //Kinvey: Mapping Function
    //      client property : backend column
    //      ----------------:---------------------------------------
    return @{@"entityId"	: KCSEntityKeyId,       //kinveyId maps to _id
			 @"meta"        : KCSEntityKeyMetadata, //meta maps to metadata
			 @"title"       : @"title",             //title maps to title
			 @"objectDescription" : @"description",       //description maps to description
			 @"thumbnailID" : @"thumbnailID",       //thumbnailID maps to thumbnailID
			 @"imageID"     : @"imageID"};          //imageID maps to imageID
}

+ (NSArray *)textFieldsName{
    return @[@"title"];
}

@end
