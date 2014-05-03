//
//  AppDelegate.h
//  QuoteApp
//
//  Created by Igor Sapyanik on 04.02.14.
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

@class AppDelegate;

@interface NSObject (AppDelegate)

- (AppDelegate *)appDelegate;

@end

@class TabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UIViewController *activityViewController;
@property (strong, nonatomic) IBOutlet TabBarController *tabBarController;
@property (weak, nonatomic) IBOutlet UIView *backgroundActivityView;

- (void)showActivityView;
- (void)hideActivityView;

- (void)startFetchingDBFromServer;

@end
