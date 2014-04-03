//
//  SideMenuViewController.h
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
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


#import <Foundation/Foundation.h>


@interface AuthenticationHelper : NSObject

+ (AuthenticationHelper *)instance;

@property (nonatomic, readonly) BOOL isSignedIn;

- (void)signUpWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock;
- (void)logout;
- (void)unregisteringCurrentDeviceOnPushServiceOnSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock;

@end
