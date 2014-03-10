//
//  ProductSubView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KinveyImageView.h"
#import "Product.h"

@interface ProductSubView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet KinveyImageView *kinveyImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;



@end
