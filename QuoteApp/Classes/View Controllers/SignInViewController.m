//
//  SignInViewController.m
//  ContentBox
//
//  Created by Igor Sapyanik on 22.01.14.
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
#import "SignInViewController.h"

#import "DejalActivityView.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)textFieldEditingDidChange:(id)sender;
@end

@implementation SignInViewController

+ (void)presentSignInFlowOnViewController:(UIViewController *)vc animated:(BOOL)animated onCompletion:(STEmptyBlock)success{
    
	if (!vc) return;
	
	SignInViewController *signInViewController = [[SignInViewController alloc] init];
	signInViewController.completionBlock = success;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:signInViewController];
	navigationController.navigationBarHidden = YES;
	[vc presentViewController:navigationController animated:animated completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc{
	DVLog(@"");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.title = LOC(SIVC_TITLE);
	[self.signUpButton setTitle:LOC(SIVC_SIGNUP)
                       forState:UIControlStateNormal];
	[self.loginButton setTitle:LOC(SIVC_LOGIN)
                      forState:UIControlStateNormal];
	self.usernameField.placeholder = LOC(SIVC_USERNAME);
	self.passwordField.placeholder = LOC(SIVC_PASSWORD);
    
    self.view.backgroundColor = BAR_COLOR;
    self.contentView.backgroundColor = BAR_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    
	[super viewWillAppear:animated];
	
	[self updateButtons];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillShow:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
	[super viewWillDisappear:animated];

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateButtons{
    
	self.signUpButton.enabled = self.loginButton.enabled = (self.usernameField.text.length && self.passwordField.text.length);
    
}

-(void)keyboardWillShow:(NSNotification *)notification{
    
	NSValue *v = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect rect = [v CGRectValue];
	rect = [self.view convertRect:rect fromView:nil];
	CGFloat keyboardHeight = CGRectGetHeight(rect);
	
	
	// get keyboard size and loctaion
	NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curveType = [curve integerValue];
    UIViewAnimationOptions animationOptions = curveType << 16;
    
    [UIView animateWithDuration:[duration doubleValue]
						  delay:0
                        options:animationOptions
                     animations:^{
                         // set views with new info
						 self.contentView.$y -= keyboardHeight / 2;
                     }
                     completion:nil];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    
	NSValue *v = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect rect = [v CGRectValue];
	rect = [self.view convertRect:rect fromView:nil];
	CGFloat keyboardHeight = CGRectGetHeight(rect);
	
	
	// get keyboard size
	NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curveType = [curve integerValue];
    UIViewAnimationOptions animationOptions = curveType << 16;
    
	
    [UIView animateWithDuration:[duration doubleValue]
						  delay:0
                        options:animationOptions
                     animations:^{
                         // set views with new info
						 self.contentView.$y += keyboardHeight / 2;
                     }
                     completion:nil];
}

- (IBAction)pressedSignUp:(id)sender{
    
	[DejalBezelActivityView activityViewForView:self.view.window];
    
    //Sing up new Kinvey user 
	[[AuthenticationHelper instance] signUpWithUsername:self.usernameField.text
                                               password:self.passwordField.text
											  onSuccess:^{
                                                  
												  [DejalActivityView removeView];
                                                  
												  [self.navigationController dismissViewControllerAnimated:NO
																								completion:^{
																									if (self.completionBlock) {
																										self.completionBlock();
																										self.completionBlock = nil;
																									}
																								}];
											  }
											  onFailure:^(NSError *error) {
                                                  
												  [DejalBezelActivityView removeView];
                                                  
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LOC(ERROR)
                                                                                                      message:error.localizedDescription ? error.localizedDescription : LOC(ERR_SMTH_WENT_WRONG)
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:LOC(OKAY)
                                                                                            otherButtonTitles:nil];
                                                  [alertView show];
											  }];
}

- (IBAction)pressedLogin:(id)sender{
    
	[DejalBezelActivityView activityViewForView:self.view.window];
    
    //Login Kinvey user
	[[AuthenticationHelper instance] loginWithUsername:self.usernameField.text
                                              password:self.passwordField.text
											 onSuccess:^{
                                                 
												 [DejalActivityView removeView];
                                                 
												 [self.navigationController dismissViewControllerAnimated:NO
																							   completion:^{
																								   if (self.completionBlock) {
																									   self.completionBlock();
																									   self.completionBlock = nil;
																								   }
																							   }];
											 }
											 onFailure:^(NSError *error) {
                                                 
												 [DejalBezelActivityView removeView];
                                                 
												 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LOC(ERROR)
                                                                                                     message:error.localizedDescription ? error.localizedDescription : LOC(ERR_SMTH_WENT_WRONG)
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:LOC(OKAY)
                                                                                           otherButtonTitles:nil];
                                                 [alertView show];
                                                 
											 }];
}


- (IBAction)textFieldEditingDidChange:(id)sender{
    
	[self updateButtons];
    
}

- (IBAction)demoPress:(id)sender {
    
    self.usernameField.text = @"demoSampleQuote";
    self.passwordField.text = @"123456";
    [self pressedLogin:sender];
    
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
	if (textField == self.usernameField) {
		[self.passwordField becomeFirstResponder];
	}
	else {
		[self.passwordField resignFirstResponder];
	}
    
	return YES;
}

@end
