//
//  BaseModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 13.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "BaseModalViewController.h"

#define TINT_COLOR [UIColor colorWithRed:0.9686 green:0.7176 blue:0.2353 alpha:1.0]
#define BAR_COLOR [UIColor colorWithRed:0.8549 green:0.3137 blue:0.1686 alpha:1.0]

@interface BaseModalViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundStatusBarView;


@end

@implementation BaseModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.toolbar.barTintColor = BAR_COLOR;
    self.toolbar.tintColor = TINT_COLOR;
    self.backgroundStatusBarView.backgroundColor = BAR_COLOR;
    self.toolbar.translucent = NO;
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

- (void)setupConstraints{
    //abstract
}

- (UIView *)getDetailSubView{
    return nil;// abstract
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closePress:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)additionalButtonPress {
    [self additionalButtonAction];
}

- (void)additionalButtonAction{
    //abstract
}

@end
