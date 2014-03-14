//
//  BaseModalViewController.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 13.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseModalViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToolbarConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightScrollViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthScrollViewConstraint;
@end
