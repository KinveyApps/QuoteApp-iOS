//
//  ProductViewCellForIPhone.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"


@class ProductViewCellForIPhone;

@protocol ProductViewCellForIPhoneDelegate <NSObject>

- (void)createNewQuoteForIPhoneFromSender:(ProductViewCellForIPhone *)sender;

@end

@interface ProductViewCellForIPhone : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) Product *item;
@property (weak, nonatomic) id<ProductViewCellForIPhoneDelegate> delegate;

@end
