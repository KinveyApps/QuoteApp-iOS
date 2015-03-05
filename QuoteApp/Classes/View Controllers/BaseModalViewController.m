//
//  BaseModalViewController.m
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

#import "BaseModalViewController.h"

@interface BaseModalViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundStatusBarView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;

@end

@implementation BaseModalViewController


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.toolbar.barTintColor = BAR_COLOR;
    self.toolbar.tintColor = TINT_COLOR;
    self.backgroundStatusBarView.backgroundColor = BAR_COLOR;
    self.toolbar.translucent = NO;
    [self.closeButton setTitle:LOC(CLOSE)];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
        
    [self setupConstraints];
    [self.view layoutIfNeeded];
    UIView *detailSubView = [self getDetailSubView];
    self.scrollView.contentSize = detailSubView.frame.size;
    [self.scrollView addSubview:detailSubView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.topToolbarConstraint.constant = 20;
    }
}

- (void)setupConstraints{ }//abstract

- (UIView *)getDetailSubView{ return nil; }// abstract


#pragma mark - Actions

- (IBAction)closePress:(id)sender {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)additionalButtonPress {
    [self additionalButtonAction];
}

- (void)additionalButtonAction{ }//abstract

@end
