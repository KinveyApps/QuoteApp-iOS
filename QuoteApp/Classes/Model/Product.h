//
//  Product.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject <KCSPersistable>

@property (nonatomic, retain) NSString *entityId;
@property (nonatomic, retain) KCSMetadata *meta;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *thumbnailID;
@property (nonatomic, retain) NSString *imageID;

@end
