//
//  MainTableViewCell.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 11.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quote.h"
#import "Order.h"

@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) id item;


@end
