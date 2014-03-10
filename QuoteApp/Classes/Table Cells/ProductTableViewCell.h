//
//  ProductTableViewCell.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@class ProductTableViewCell;

@protocol ProductTableViewCellDelegate <NSObject>

- (void)createNewQuoteFromSender:(ProductTableViewCell *)sender;

@end

@interface ProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) Product *item;

@property (weak, nonatomic) id<ProductTableViewCellDelegate> delegate;

@end
