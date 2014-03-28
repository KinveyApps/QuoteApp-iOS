//
//  AppDelegate.m
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

#import "AppDelegate.h"
#import "SignInViewController.h"
#import "TabBarController.h"

@implementation NSObject (AppDelegate)

- (AppDelegate *)appDelegate {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
@interface AppDelegate ()

@property (nonatomic) BOOL isCompleteLoadQuotes;
@property (nonatomic) BOOL isCompleteLoadOrders;
@property (nonatomic) BOOL isCompleteLoadProducts;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DEBUG
    //Kinvey: Setup configuration
	[KCSClient configureLoggingWithNetworkEnabled:YES
									 debugEnabled:YES
									 traceEnabled:YES
								   warningEnabled:YES
									 errorEnabled:YES];
#endif

	//Kinvey: Start push service
    [KCSPush registerForPush];
	
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.backgroundActivityView.backgroundColor = BAR_COLOR;
	
	if (![[AuthenticationHelper instance] isSignedIn]) {
		[SignInViewController presentSignInFlowOnViewController:self.window.rootViewController
                                                       animated:NO
												   onCompletion:^{
													   [self startFetchingDBFromServer];
												   }];
	}
	else {
		[self startFetchingDBFromServer];
	}
	[self startListening];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //Kinvey: Rigstration on push service
    [[KCSPush sharedPush] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken completionBlock:^(BOOL success, NSError *error) {
    }];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //Kinvey: Get remote notification
    [[KCSPush sharedPush] application:application didReceiveRemoteNotification:userInfo];
}
- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    //Kinvey: Fail to register for remote notification
    [[KCSPush sharedPush] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
    //Kinvey: register for remote notification
    [[KCSPush sharedPush] registerForRemoteNotifications];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
    //Kinvey: Clean-up Push Service
    [[KCSPush sharedPush] onUnloadHelper];
}

- (void)showActivityView{
	
	if (!self.activityViewController.presentingViewController)
		[self.window.rootViewController presentViewController:self.activityViewController animated:NO completion:nil];
}

- (void)hideActivityView{
    
    if (self.isCompleteLoadOrders && self.isCompleteLoadQuotes && self.isCompleteLoadProducts) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityViewController dismissViewControllerAnimated:NO completion:nil];
        });
    }
}

- (void)startFetchingDBFromServer{
	
	[self showActivityView];
	
    //Kinvey: update user data form server
	[[KCSUser activeUser] refreshFromServer:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		
		if (errorOrNil){
			DLog(@"%@", errorOrNil.localizedDescription);
            
            [self.activityViewController dismissViewControllerAnimated:NO completion:nil];
            
            [SignInViewController presentSignInFlowOnViewController:self.window.rootViewController
                                                           animated:NO
                                                       onCompletion:^{
                                                           [self startFetchingDBFromServer];
                                                       }];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign In Error"
                                                                message:errorOrNil.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:LOC(CANCEL)
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }else{
            
            //Preload data form all collection to cache
            [[DataHelper instance] loadQuotesUseCache:NO
                                    containtSubstinrg:nil
                                            OnSuccess:^(NSArray *quotes){
                                                self.isCompleteLoadQuotes = YES;
                                                [self hideActivityView];
                                            }
                                            onFailure:^(NSError *error){
                                                self.isCompleteLoadQuotes = YES;
                                                [self hideActivityView];
                                            }];
            
            [[DataHelper instance] loadOrdersUseCache:NO
                                    containtSubstinrg:nil
                                            OnSuccess:^(NSArray *orders){
                                                self.isCompleteLoadOrders = YES;
                                                [self hideActivityView];
                                            }
                                            onFailure:^(NSError *error){
                                                self.isCompleteLoadOrders = YES;
                                                [self hideActivityView];
                                            }];
            
            [[DataHelper instance] loadProductsUseCache:NO
                                      containtSubstinrg:nil
                                              OnSuccess:^(NSArray *products){
                                                  self.isCompleteLoadProducts = YES;
                                                  [self hideActivityView];
                                              }
                                              onFailure:^(NSError *error){
                                                  self.isCompleteLoadProducts = YES;
                                                  [self hideActivityView];
                                              }];
        }
	}];
}

- (void)startListening{
    
    //Kinvey: Listen notification about kinvey network activity
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(show)
                                                 name:KCSNetworkConnectionDidStart
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hide)
                                                 name:KCSNetworkConnectionDidEnd
                                               object:nil];
}

- (void) show{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void) hide{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
