//
//  SettingModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "SettingModalViewController.h"
#import "SettingsSubView.h"

#define SCROOLL_VIEW_INSETS_FOR_IPHONE 20
#define SCROOLL_VIEW_INSETS_FOR_IPAD 40

@interface SettingModalViewController ()

@property (strong, nonatomic) SettingsSubView *detailSubView;

@end

@implementation SettingModalViewController

- (instancetype)init{
    self = [self initWithNibName:@"BaseModalViewController" bundle:nil];
    return self;
}

-(UIView *)getDetailSubView{
    self.detailSubView = [[SettingsSubView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    self.rightButton.title = @"";
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
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - SCROOLL_VIEW_INSETS_FOR_IPAD * 2;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height - SCROOLL_VIEW_INSETS_FOR_IPAD;
    }else{
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height - 20 - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notification

- (void)keyboardShow:(NSNotification *)notification{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.scrollView.contentOffset = CGPointMake(0, 100);
                         }];
    }else{
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.scrollView.contentOffset = CGPointMake(0, 100);
                             }];
        }
    }
    
}

- (void)keyboardHide:(NSNotification *)nofification{
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.scrollView.contentOffset = CGPointZero;
                     }];
    
}

@end
