//
//  AppDelegate.h
//  QuoteApp
//
//  Created by Igor Sapyanik on 04.02.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

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
