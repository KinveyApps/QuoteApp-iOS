//
//  NSArray+Utils.m
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

#import "NSArray+Utils.h"
#import <math.h>

@implementation NSArray (Utils)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return [NSArray arrayWithArray:array];
}

-(id)firstObject {
	return [self count] ? [self objectAtIndex:0] : nil;
}

-(NSArray *)arrayByAddingNewValuesFromArray:(NSArray *)otherArray {
	NSArray *newObjects = [otherArray arrayWithValuesSatisfyingBlock:^(id value) {	return (BOOL)![self containsObject:value]; }];
	return [self arrayByAddingObjectsFromArray:newObjects];
}

- (BOOL)containsValuesFromArray:(NSArray *)otherArray {
    for (id value in self)
        if ([otherArray containsObject:value])
            return YES;
    
    return NO;
}

- (NSArray *)uniqueValues {
	NSMutableArray *uniqueValues = [NSMutableArray arrayWithCapacity:self.count];
	
	for (id value in self)
		if (![uniqueValues containsObject:value])
			[uniqueValues addObject:value];

	return uniqueValues.count ? [NSArray arrayWithArray:uniqueValues] : nil;
}

- (NSArray *)arrayByRemovingObject:(id)object {
	if (!object || ![self containsObject:object]) return [NSArray arrayWithArray:self];

	NSMutableArray *array = [NSMutableArray arrayWithArray:self];
	[array removeObject:object];
	return [NSArray arrayWithArray:array];
}

-(NSArray *)arrayWithValuesReturnedFromBlock:(id (^)(id value))block {
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:[self count]];
	for (id value in self) {
		id ret = block ? block(value) : nil;
		if (ret) [values addObject:ret];
	}
	return [NSArray arrayWithArray:values];
}

-(NSArray *)arrayWithValuesSatisfyingBlock:(BOOL (^)(id value))block {
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:[self count]];
	for (id value in self) if (block && block(value))
		[values addObject:value];
	return [NSArray arrayWithArray:values];
}

-(BOOL)allValuesSatisfyBlock:(BOOL (^)(id value))block {
	if (!self.count) return NO;
	for (id value in self) if (!block || !block(value)) return NO;
	return YES;
}
-(BOOL)someValuesSatisfyBlock:(BOOL (^)(id value))block {
	for (id value in self) if (block && block(value)) return YES;
	return NO;
}

-(id)firstValueSatisfyingBlock:(BOOL (^)(id value))block {
	for (id value in self) if (block && block(value))
		return value;
	return nil;
}

-(id)firstNonNilValueReturnedFromBlock:(id (^)(id value))block {
	if (!block) return nil;
	for (id value in self) {
		id ret = block(value);
		if (ret) return ret;
	}
	return nil;
}

-(NSUInteger)middleIndex {
	return self.count ? ceilf(((float)(self.count)/2.0)) - 1 : 0;
}

- (va_list)copyVaList {
	id *vl = NULL;
	if (self.count) {
		vl = malloc(sizeof(id) * (self.count + 1));
		[self getObjects:vl range:NSMakeRange(0, self.count)];
		vl[self.count] = NULL;
	}
	return (va_list)vl;
}

- (NSArray *)intersetArray:(NSArray *)array {
    return [self arrayWithValuesSatisfyingBlock:^(id value) { return [array containsObject:value]; }];
}

@end
