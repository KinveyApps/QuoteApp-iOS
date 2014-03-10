//
//  QuoteOrderDetailView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "BaseDetailView.h"
#import "Quote.h"

@interface QuoteOrderDetailView : BaseDetailView

@property (strong, nonatomic) Quote *item;

@end
