//
//  AppDelegate.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 04.02.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

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
	[KCSClient configureLoggingWithNetworkEnabled:YES
									 debugEnabled:YES
									 traceEnabled:YES
								   warningEnabled:YES
									 errorEnabled:YES];
#endif
	
	//Start push service
    [KCSPush registerForPush];
	
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	
	[UINavigationBar appearance].tintColor = [UIColor appTextColor];
	[UINavigationBar appearance].barTintColor = [UIColor appTintColor];
	[UINavigationBar appearance].tintColor = [UIColor appTextColor];
	[UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor appTextColor] };
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.backgroundActivityView.backgroundColor = [UIColor colorWithRed:0.8549 green:0.3137 blue:0.1686 alpha:1.0];
	
	if (![[AuthenticationHelper instance] isSignedIn]) {
		[SignInViewController presentSignInFlowOnViewController:self.window.rootViewController animated:NO
												   onCompletion:^{
													   [self startFetchingDBFromServer];
												   }];
	}
	else {
		[self startFetchingDBFromServer];
	}
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showActivityView
{
	
	if (!self.activityViewController.presentingViewController)
		[self.window.rootViewController presentViewController:self.activityViewController animated:NO completion:nil];
}

- (void)hideActivityView
{
    if (self.isCompleteLoadOrders && self.isCompleteLoadQuotes && self.isCompleteLoadProducts) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityViewController dismissViewControllerAnimated:NO completion:nil];
        });
    }
}

- (void)startFetchingDBFromServer
{
	
	[self showActivityView];
	
	[[KCSUser activeUser] refreshFromServer:^(NSArray *objectsOrNil, NSError *errorOrNil) {
		
		if (errorOrNil)
			DLog(@"%@", errorOrNil.localizedDescription);
        
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
		

		/*
		DataHelper *dataHelper = [DataHelper instance];
		[dataHelper loadMarketsUsingCache:NO onSuccess:^(NSArray *markets) {
			
			[dataHelper loadContentTypesUsingCache:NO onSuccess:^(NSArray *contentTypes) {
				
				[dataHelper loadContentItemsUsingCache:NO onSuccess:^(NSArray *contentItems) {
					
					// we've updated all the data
					[[KCSPush sharedPush] resetPushBadge];
					[self.sideMenuViewController initializeOpenDefaultScreenAndThen:^(NSError *error) {
						if (!error) {
							[self hideActivityView];
						}
						else {
							errorBlock(error);
						}
					}];
				}
											 onFailure:errorBlock];
				
			}
										 onFailure:errorBlock];
		 } onFailure:errorBlock];
		*/
	}];
}

@end
