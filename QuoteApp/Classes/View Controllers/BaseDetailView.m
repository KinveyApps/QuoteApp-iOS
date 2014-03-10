//
//  BaseDetailView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "BaseDetailView.h"

#define BLUR_CORNER_RADIUS 15.0f
#define BUTTON_CORNER_RADIUS 5.0f
#define ADDITIONAL_BUTTON_BOTTOM_INSET_DEFAULT_VALUE 8.0

@interface BaseDetailView ()

@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (weak, nonatomic) IBOutlet UIView *horizontalSepartorView;


@end

@implementation BaseDetailView

#pragma mark - Initialisation 

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [[NSBundle mainBundle] loadNibNamed:@"BaseDetailView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    self.blurView.layer.cornerRadius = BLUR_CORNER_RADIUS;
    self.additionalButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;

    [self.blurView setClipsToBounds:YES];
    [self setBlurForView:self.blurView];
    
    [self setupConstraints];
    
    UIView *detailSubView = [self getDetailSubView];
    self.scrollView.contentSize = detailSubView.frame.size;
    [self.scrollView addSubview:detailSubView];
    
    [self.additionalButton setTitle:LOC(DV_BUTTON_RECREATE_ORDER) forState:UIControlStateNormal];
    [self.leftButton setTitle:LOC(DV_BUTTON_SUBMIT_ORDER) forState:UIControlStateNormal];
    [self.rightButton setTitle:LOC(CANCEL) forState:UIControlStateNormal];
    [self.centerButton setTitle:LOC(CLOSE) forState:UIControlStateNormal];
}

- (void)setupConstraints{
    //abstract
}

- (UIView *)getDetailSubView{
    return nil;// abstract
}

- (void)setBlurForView:(UIView *)view{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:[self bounds]];
    toolbar.translucent = YES;
    [view insertSubview:toolbar atIndex:0];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|"
                                                                 options:0
                                                                 metrics:0
                                                                   views:NSDictionaryOfVariableBindings(toolbar)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[toolbar]|"
                                                                 options:0
                                                                 metrics:0
                                                                   views:NSDictionaryOfVariableBindings(toolbar)]];
}

#pragma mark - Setters and Getters

- (void)setNumberButtonType:(NumberButtonDetailViewType)numberButtonType{
    switch (numberButtonType) {
        case OneButtonDetailViewType:
        {
            self.rightButton.hidden = YES;
            self.leftButton.hidden = YES;
            self.horizontalSepartorView.hidden = YES;
            self.centerButton.hidden = NO;
            self.additionalButton.hidden = YES;
            self.bottomConstraint.constant = -self.additionalButton.frame.size.height;
        }break;
        case TwoButtonDetailViewType:
        {
            self.rightButton.hidden = NO;
            self.leftButton.hidden = NO;
            self.horizontalSepartorView.hidden = NO;
            self.centerButton.hidden = YES;
            self.additionalButton.hidden = YES;
            self.bottomConstraint.constant = -self.additionalButton.frame.size.height;
        }break;
        case OneButtonWithAdditionalButtonDetailViewType:
        {
            self.rightButton.hidden = YES;
            self.leftButton.hidden = YES;
            self.horizontalSepartorView.hidden = YES;
            self.centerButton.hidden = NO;
            self.additionalButton.hidden = NO;
            self.bottomConstraint.constant = ADDITIONAL_BUTTON_BOTTOM_INSET_DEFAULT_VALUE;
        }break;
        default:
            break;
    }
    [self layoutIfNeeded];
}

#pragma mark - Actions

- (IBAction)rightButtonPress {
    [self rightButtonAction];
}

- (void)rightButtonAction{
    //abstract
}

- (IBAction)centerButtonPress {
    [self centerButtonAction];
}

- (void)centerButtonAction{
    //abstract
}

- (IBAction)leftButtonPress {
    [self leftButtonAction];
}


- (void)leftButtonAction{
    //abstract
}

- (IBAction)additionalButtonPress {
    [self additionalButtonAction];
}

- (void)additionalButtonAction{
    //abstract
}

@end
