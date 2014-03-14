//
//  ProductModalViewController.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "BaseModalViewController.h"
#import "Product.h"

@interface ProductModalViewController : BaseModalViewController

@property (strong, nonatomic) Product *item;

@end
