//
//  SideMenuViewController.h
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import "AuthenticationHelper.h"

@implementation AuthenticationHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(AuthenticationHelper)

- (id)init {
	self = [super init];
	if (self) {
		(void)[[KCSClient sharedClient] initializeKinveyServiceForAppKey:KINVEY_APP_KEY
														   withAppSecret:KINVEY_APP_SECRET
															usingOptions:nil];

	}
	return self;
}

- (void)signUpWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock {
	
	[KCSUser userWithUsername:username
                     password:password
              fieldsAndValues:nil
          withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
              if (!errorOrNil) {
                  if (successBlock) successBlock();
              }
              else {
                  if (failureBlock) failureBlock(errorOrNil);
              }
          }];
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock {
	
	[KCSUser loginWithUsername:username
                      password:password
           withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
               if (!errorOrNil) {
                   if (successBlock) successBlock();
               }
               else {
                   if (failureBlock) failureBlock(errorOrNil);
               }
           }];
}


- (BOOL)isSignedIn
{
    return [KCSUser activeUser] != nil;
}

- (void)logout
{
	[[KCSUser activeUser] logout];
}

@end
