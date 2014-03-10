//
//  QuoteOrderSubView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quote.h"

@interface QuoteOrderSubView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) Quote *item;



@end
