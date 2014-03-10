//
//  CVUser.m
//  ContentBox
//
//  Created by Igor Sapyanik on 22.01.14.
//  Copyright (c) 2014 Igor Sapyanik. All rights reserved.
//

#import "KCSUser+ContentBox.h"

@implementation KCSUser (ContentBox)

@dynamic ordering;

- (NSArray *)ordering
{
	return [self getValueForAttribute:@"ordering"];
}

- (void)setOrdering:(NSArray *)ordering
{
	if (![self.ordering isEqual:ordering]) {
		
		[self setValue:ordering forAttribute:@"ordering"];
		[self saveWithCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
			if (errorOrNil) {
				DLog(@"%@", errorOrNil.localizedDescription);
			}
		}];
	}
}

@end
