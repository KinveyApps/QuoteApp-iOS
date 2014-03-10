//
//  NSDictionary+Utils.m
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

#import "NSDictionary+Utils.h"
#import "NSString+Utils.h"


@implementation NSDictionary (Utils)

+(id)dictionaryWithKeysAndValues:(id)firstKey, ... {
	NSMutableArray * keys = [NSMutableArray array];
	NSMutableArray * values = [NSMutableArray array];

	va_list argumentList;
	if (firstKey) {
		va_start(argumentList, firstKey);
		id valueForKey = va_arg(argumentList, id);
		if (valueForKey) {
			[keys addObject:firstKey];
			[values addObject:valueForKey];
		}

		id currentKey;
		while ((currentKey = va_arg(argumentList, id))) {
			valueForKey = va_arg(argumentList, id);
			if (valueForKey) {
				[keys addObject:currentKey];
				[values addObject:valueForKey];
			}
		}
		va_end(argumentList);
	}

	return [self dictionaryWithObjects:values forKeys:keys];
}

+(id)dictionaryWithURLEncodedString:(NSString *)string{
	NSMutableArray * keys = [NSMutableArray array];
	NSMutableArray * values = [NSMutableArray array];

	NSArray *paramsArray = [string componentsSeparatedByString:@"&"];
	for (NSString *prop in paramsArray) {
		NSArray *keyAndValue = [prop componentsSeparatedByString:@"="];
		NSString *key   = [[keyAndValue objectAtIndex:0] URLDecoded];
		NSString *value = [[keyAndValue objectAtIndex:1] URLDecoded];
		[keys addObject:key];
		[values addObject:value];
	}

	return [self dictionaryWithObjects:values forKeys:keys];
}

+(NSString *)formUrlEncodeForKey:(NSString *)key value:(id)value keyPrefix:(NSString *)keyPrefix {
	NSMutableString *result = [NSMutableString stringWithCapacity:2048];
	
	NSString *keyWithPrefix = keyPrefix ? [NSString stringWithFormat:@"%@.%@", keyPrefix, key] : key;
	
	if ([value isKindOfClass:NSDictionary.class]) {
		NSEnumerator * keys = [value keyEnumerator];
		id innerKey;
		while ((innerKey = [keys nextObject])) {
			if (result.length) [result appendString:@"&"];
			NSString *prop = [self formUrlEncodeForKey:innerKey value:[value valueForKey:innerKey]
											 keyPrefix:keyWithPrefix];
			[result appendString:prop];
		}
	}
	else if ([value isKindOfClass:NSString.class]) {
		NSString *prop = [NSString stringWithFormat:@"%@=%@", [keyWithPrefix URLEncoded], [value URLEncoded]];
		[result appendString:prop];
	}
	else if ([value isKindOfClass:NSNumber.class] && !strcmp([value objCType], @encode(BOOL))){
		NSString *prop = [NSString stringWithFormat:@"%@=%@", [keyWithPrefix URLEncoded], [value boolValue] ? @"true" : @"false"];
		[result appendString:prop];
	}
	else {
		NSString *prop = [NSString stringWithFormat:@"%@=%@", [keyWithPrefix URLEncoded], value];
		[result appendString:prop];
	}
	
	return result;
}

-(NSData *)formUrlEncode {
	NSMutableData *data = [NSMutableData dataWithCapacity:2048];
	NSEnumerator * keys = [self keyEnumerator];
	id key;
	
	while ((key = [keys nextObject])) {
		if ([data length]) [data appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
		
		NSString *value = [self valueForKey:key];
		NSString *keyValue = [self.class formUrlEncodeForKey:key value:value keyPrefix:nil];
		[data appendData:[keyValue dataUsingEncoding:NSUTF8StringEncoding]];
	}
	return data;
}

#pragma mark -

-(id)nonNSNullValueForKey:(NSString *)key {
	id value = [self valueForKey:key];
	return [value isKindOfClass:NSNull.class] ? nil : value;
}

-(id)valueForKey:(NSString *)key expectingType:(Class)type {
	id value = [self nonNSNullValueForKey:key];
	return [value isKindOfClass:type] ? value : nil;
}

-(id)valueForKey:(NSString *)key conformsToProtocol:(Protocol *)protocol {
	id value = [self nonNSNullValueForKey:key];
	return [value conformsToProtocol:protocol] ? value : nil;
}

-(id)valueForKey:(NSString *)key expectingSelector:(SEL)selector {
	id value = [self nonNSNullValueForKey:key];
	return [value respondsToSelector:selector] ? value : nil;
}


@end
