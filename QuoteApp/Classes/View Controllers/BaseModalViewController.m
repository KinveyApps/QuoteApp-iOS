//
//  BaseModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 13.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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
