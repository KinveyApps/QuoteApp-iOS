//
//  SettingsDetailView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 6.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "SettingsDetailView.h"
#import "SettingsSubView.h"

#define SCROLL_VIEW_INSET_FOR_IPAD 40
#define SCROLL_VIEW_TOP_INSET_FOR_IPAD 20
#define BLUR_VIEW_WIDHT_FOR_IPAD 460
#define BLUR_VIEW_HEIGHT_FOR_IPAD 420
#define SCROLL_VIEW_INSET_FOR_IPHONE 5
#define SCROLL_VIEW_TOP_INSET_FOR_IPHONE 10
#define BLUR_VIEW_INSET_FOR_IPHINE 40
#define BLUR_VIEW_TOP_INSET_FOR_IPHINE 10
#define TOP_BLUR_VIEW_CONSTRAINT_KEYBOARD_SHOW_CONSTANT_FOR_IPHONE -105
#define TOP_BLUR_VIEW_CONSTRAINT_KEYBOARD_SHOW_CONSTANT_FOR_IPAD 20

@interface SettingsDetailView ()

@property (strong, nonatomic) SettingsSubView *detailSubView;

@end

@implementation SettingsDetailView

#pragma mark - Initialisation

-(UIView *)getDetailSubView{
    self.detailSubView = [[SettingsSubView alloc] initWithFrame:CGRectMake(0, 0, self.widhtConstraint.constant - self.leftConstraint.constant - self.rightConstraint.constant, self.scrollView.frame.size.height)];
    self.numberButtonType = OneButtonDetailViewType;
    self.scrollView.scrollEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    return self.detailSubView;
}

- (void)setupConstraints{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widhtConstraint.constant = BLUR_VIEW_WIDHT_FOR_IPAD;
        self.heightConstrait.constant = BLUR_VIEW_HEIGHT_FOR_IPAD;
        self.topConstraint.constant = SCROLL_VIEW_TOP_INSET_FOR_IPAD;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
    }else{
        self.widhtConstraint.constant = self.bounds.size.width - BLUR_VIEW_TOP_INSET_FOR_IPHINE;
        self.heightConstrait.constant = self.bounds.size.height - BLUR_VIEW_INSET_FOR_IPHINE;
        self.topConstraint.constant = SCROLL_VIEW_TOP_INSET_FOR_IPHONE;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (void)centerButtonAction{
    [self removeFromSuperview];
}

#pragma mark - Keyboard Notification

- (void)keyboardShow:(NSNotification *)notification{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.topBlurViewConstraint.constant = TOP_BLUR_VIEW_CONSTRAINT_KEYBOARD_SHOW_CONSTANT_FOR_IPHONE;
                             self.topBlurViewConstraint.priority = UILayoutPriorityDefaultHigh;
                             self.centerYBlurViewConstraint.priority = UILayoutPriorityDefaultLow;
                             [self layoutIfNeeded];
                         }];
    }else{
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.topBlurViewConstraint.priority = UILayoutPriorityDefaultHigh;
                                 self.topBlurViewConstraint.constant = TOP_BLUR_VIEW_CONSTRAINT_KEYBOARD_SHOW_CONSTANT_FOR_IPAD;
                                 self.centerYBlurViewConstraint.priority = UILayoutPriorityDefaultLow;
                                 [self layoutIfNeeded];
                             }];
        }
    }
    
}

- (void)keyboardHide:(NSNotification *)nofification{
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.centerYBlurViewConstraint.priority = UILayoutPriorityDefaultHigh;
                         self.topBlurViewConstraint.priority = UILayoutPriorityDefaultLow;
                         [self layoutIfNeeded];
                     }];

}

@end
