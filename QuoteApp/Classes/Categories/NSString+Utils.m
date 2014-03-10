//
//  NSString+Utils.m
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

#import <Foundation/Foundation.h>
#import "NSString+Utils.h"


@implementation NSString (Utils)

#pragma mark URL Encoding

-(NSString *)URLEncoded {
	return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
}
-(NSString *)URLDecoded {
	return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//we reuse date formatter for performance reasons
+ (NSDateFormatter *)defaultDateFormatter {
	static NSDateFormatter *dateFormat;
	if (!dateFormat)
		dateFormat = [[NSDateFormatter alloc] init];
	
	dateFormat.dateFormat = nil;
	return dateFormat;
}


+ (NSString *)stringForTimeInterval:(NSTimeInterval)timeInterval withDateFormat:(NSString *)dateFormat {

	long seconds = lroundf(timeInterval); // Modulo (%) operator below needs int or long
	
	int hour = seconds / 3600;
	int mins = (seconds % 3600) / 60;
	int secs = seconds % 60;
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setYear:2013];
	[comps setMonth:1];
	[comps setDay:1];
	[comps setHour:hour];
	[comps setMinute:mins];
	[comps setSecond:secs];
	NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
	
	NSDateFormatter *formatter = [self defaultDateFormatter];
	formatter.dateFormat = dateFormat;
	return [formatter stringFromDate:date];
}

@end
