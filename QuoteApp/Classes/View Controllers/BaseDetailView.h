//
//  BaseDetailView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OneButtonDetailViewType = 0,
	TwoButtonDetailViewType,
    OneButtonWithAdditionalButtonDetailViewType,
} NumberButtonDetailViewType;

@interface BaseDetailView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;
@property (weak, nonatomic) IBOutlet UIButton *additionalButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *leftButtonSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *additionalButtonSpinner;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widhtConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBlurViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYBlurViewConstraint;

@property (nonatomic) NumberButtonDetailViewType numberButtonType;

- (UIView *)getDetailSubView;//abstract
- (void)setupConstraints;//abstract

- (void)leftButtonAction;//abstract
- (void)rightButtonAction;//abstract
- (void)centerButtonAction;//abstrct
- (void)additionalButtonAction;//abstract

@end
