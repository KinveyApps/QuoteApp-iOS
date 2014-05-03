//
//  BaseModalViewController.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 13.3.14.
/**
 * Copyright (c) 2014 Kinvey Inc. *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at *
 * http://www.apache.org/licenses/LICENSE-2.0 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License. *
 */

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
