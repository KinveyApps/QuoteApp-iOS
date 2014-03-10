//
//  NSObject+Utils.h
//  STLib
//
//    The MIT License (MIT)
//
//    Created by Softteco on 2010-09-28.
//    Softteco LLC. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//
//

#import "NSObject+Utils.h"

void measure_exec_time(STEmptyBlock block) {
	if (!block) return;
	
	NSTimeInterval startInterval = [NSDate timeIntervalSinceReferenceDate];
	block();
	NSTimeInterval endInterval = [NSDate timeIntervalSinceReferenceDate];
	NSLog(@"execution time: %f", endInterval-startInterval);
}

@implementation NSObject (Utils)

- (void)performBlock:(STEmptyBlock)block afterDelay:(NSTimeInterval)delay 
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

- (void)pollUntilCondition:(BOOL (^)())conditionBlock pollingInterval:(NSTimeInterval)delay timeout:(NSTimeInterval)timeout completionBlock:(STEmptyBlock)block timeoutBlock:(STEmptyBlock)timeoutBlock {
	if (!block) return;

	if (timeout < 0) {
		if (timeoutBlock) timeoutBlock();
		return;
	}
	
	if (!conditionBlock || conditionBlock()) {
		block();
		return;
	}
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay*NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[self pollUntilCondition:conditionBlock pollingInterval:delay timeout:(timeout-delay) completionBlock:block timeoutBlock:timeoutBlock];
	});
}
@end
