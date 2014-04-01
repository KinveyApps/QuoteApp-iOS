//
//  SettingModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.3.14.
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

#import "SettingModalViewController.h"
#import "SettingsSubView.h"
#import "SignInViewController.h"

#define SCROOLL_VIEW_INSETS_FOR_IPHONE 20
#define SCROOLL_VIEW_INSETS_FOR_IPAD 40

@interface SettingModalViewController ()

@property (strong, nonatomic) SettingsSubView *detailSubView;

@end

@implementation SettingModalViewController


#pragma mark - Initialization

- (instancetype)init{
    
    self = [self initWithNibName:@"BaseModalViewController" bundle:nil];
    return self;
}


#pragma mark - View Life Cycle

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupConstraints{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - SCROOLL_VIEW_INSETS_FOR_IPAD * 2;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height - SCROOLL_VIEW_INSETS_FOR_IPAD;
    }else{
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
    }
}

-(UIView *)getDetailSubView{
    
    self.detailSubView = [[SettingsSubView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    
    [self.rightButton setTitle:LOC(SVC_BUTTON_LOGOUT)];
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


#pragma mark - Keyboard Notification

- (void)keyboardShow:(NSNotification *)notification{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:ANIMATION_DURATION
                         animations:^{
                             self.scrollView.contentOffset = CGPointMake(0, 100);
                         }];
    }else{
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [UIView animateWithDuration:ANIMATION_DURATION
                             animations:^{
                                 self.scrollView.contentOffset = CGPointMake(0, 100);
                             }];
        }
    }
    
}

- (void)keyboardHide:(NSNotification *)nofification{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.scrollView.contentOffset = CGPointZero;
                     }];
    
}


#pragma mark - Actions

- (void)additionalButtonAction{
    
    [[AuthenticationHelper instance] unregisteringCurrentDeviceOnPushServiceOnSuccess:^{
        
        [[AuthenticationHelper instance] logout];
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     [SignInViewController presentSignInFlowOnViewController:[UIApplication sharedApplication].appDelegate.window.rootViewController
                                                                                    animated:YES
                                                                                onCompletion:^{
                                                                                    [[UIApplication sharedApplication].appDelegate startFetchingDBFromServer];
                                                                                }];
                                 }];
    }
                                                                            onFailure:nil];
}

@end
