//
//    AlertViewController.m
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

#import "AlertViewController.h"
#import "NSArray+Utils.h"

@interface AlertViewController()
@property (nonatomic, retain) UIAlertView *currentAlertView;
@property (nonatomic, copy) void(^block)(NSInteger);

-(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))b
			cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstOtherButtonTitle otherButtonTitlesVaList:(va_list)valist;

@end

@implementation AlertViewController

@synthesize block, currentAlertView;

+(AlertViewController *)defaultController {
	static AlertViewController *controller;
	if (!controller) {
		controller = [[AlertViewController alloc] init];
	}
	return controller;
}

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))block
				 cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)firstOtherButtonTitle {
	AlertViewController *def = [self defaultController];
	
	va_list vl = NULL;
	if (firstOtherButtonTitle) {
		NSArray *buttonTitles = [NSArray arrayWithObject:firstOtherButtonTitle];
		vl = [buttonTitles copyVaList];
	}
	
	[def showAlertViewWithTitle:title message:message block:block cancelButtonTitle:cancelButtonTitle firstOtherButtonTitle:firstOtherButtonTitle otherButtonTitlesVaList:vl];

	free(vl);
}

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))block
			cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)firstOtherButtonTitle, ... {
	AlertViewController *def = [self defaultController];
	
	va_list input_vl;
	va_start(input_vl, firstOtherButtonTitle);
	
	NSMutableArray *otherButtonTitles = [NSMutableArray array];
	for (NSString *buttonTitle = firstOtherButtonTitle; buttonTitle != nil; buttonTitle = va_arg(input_vl, NSString *))
		if (buttonTitle)
			[otherButtonTitles addObject:buttonTitle];

	va_end(input_vl);
	
	
	va_list vl = [otherButtonTitles copyVaList];
	[def showAlertViewWithTitle:title message:message block:block cancelButtonTitle:cancelButtonTitle firstOtherButtonTitle:firstOtherButtonTitle otherButtonTitlesVaList:vl];
	free(vl);
}


- (void)dealloc
{
	DVLog(@"");
}

-(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))b
			cancelButtonTitle:(NSString *)cancelButtonTitle firstOtherButtonTitle:(NSString *)firstOtherButtonTitle otherButtonTitlesVaList:(va_list)valist {

	if (currentAlertView) [currentAlertView dismissWithClickedButtonIndex:0 animated:NO];

	self.block = b;

	self.currentAlertView = [[UIAlertView alloc] initWithTitle:title message:message
													  delegate:self
											 cancelButtonTitle:cancelButtonTitle
											 otherButtonTitles:nil];
	
	
	if (valist) {
		NSString * title = nil;
		while( (title = va_arg(valist, NSString *)) ) {
			[currentAlertView addButtonWithTitle:title];
		}
    }
	
	
	[currentAlertView show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	void(^oldBlock)(NSInteger) = block;
	if (block) block(buttonIndex);
	if (block == oldBlock) self.block = nil;
	self.currentAlertView = nil;
}

@end
