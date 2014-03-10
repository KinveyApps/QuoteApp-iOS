//
//  SideMenuViewController.h
//  ContentBox
//
//  Created by Igor Sapyanik on 14.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KINVEY_APP_KEY				@"kid_PVSldxB6vq"
#define KINVEY_APP_SECRET			@"51dd16bd82434ad4b5383df1e70bc9e6"
#define KINVEY_MASTER_SECRET		@"50cff30d3eab44678636b69cd7cb2bdd"

#define KINVEY_PUSH_KEY				@"kid_eVmOXYVcbJ"
#define KINVEY_PUSH_SECRET			@"c9fdbd42a2d242619509b89960f4c49e"
#define KINVEY_PUSH_MASTER_SECRET	@"a1fb96daecbd4363af769fb720c0bca7"



@interface AuthenticationHelper : NSObject

+ (AuthenticationHelper *)instance;

@property (nonatomic, readonly) BOOL isSignedIn;

- (void)signUpWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password onSuccess:(STEmptyBlock)successBlock onFailure:(STErrorBlock)failureBlock;
- (void)logout;
@end
