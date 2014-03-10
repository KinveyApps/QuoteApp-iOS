//
//  UIColor+Utils.m
//  Softteco
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

#import "UIColor+Utils.h"


#define UIColor256(n) fraction * n
const CGFloat fraction = 1.0/255;

@implementation UIColor (Utils)

+ (UIColor *)colorWith256Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
	return [UIColor colorWithRed:UIColor256(red) green:UIColor256(green) blue:UIColor256(blue) alpha:UIColor256(alpha)];
}

- (UIImage *)stretchableImage {
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [self CGColor]);
	CGRect rect = CGRectMake(0, 0, 1, 1);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return [image resizableImageWithCapInsets:UIEdgeInsetsZero];
}

@end
