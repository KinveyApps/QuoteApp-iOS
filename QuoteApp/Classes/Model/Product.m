//
//  Product.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "Product.h"

@implementation Product

- (NSDictionary *)hostToKinveyPropertyMapping
{
    return @{
			 @"entityId"	: KCSEntityKeyId,
			 @"meta"        : KCSEntityKeyMetadata,
			 @"title"       : @"title",
			 @"description" : @"description",
			 @"thumbnailID" : @"thumbnailID",
			 @"imageID"     : @"imageID",
			 };
}

@end
