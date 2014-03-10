//
//  SignInViewController.h
//  ContentBox
//
//  Created by Igor Sapyanik on 22.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController

+ (void)presentSignInFlowOnViewController:(UIViewController *)vc animated:(BOOL)animated onCompletion:(STEmptyBlock)success;

@property (nonatomic, copy) STEmptyBlock completionBlock;

@end
