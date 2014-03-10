//
//  NSDictionary+Utils.h
//  STLibAPI
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


@interface NSDictionary (Utils)

+(id)dictionaryWithKeysAndValues:(id)firstObject , ... NS_REQUIRES_NIL_TERMINATION;
+(id)dictionaryWithURLEncodedString:(NSString *)string;

-(id)nonNSNullValueForKey:(NSString *)key;

/**
 * @brief Get the dictionary value for a specific key and return nil unless of the expected type
 *
 * @param key the key of the value
 * @param type the expected type of the value
 */
-(id)valueForKey:(NSString *)key expectingType:(Class)type;
/**
 * @brief Get the dictionary value for a specific key and return nil unless of the expected type
 *
 * @param key the key of the value
 * @param type the protocol the value should conform to
 */
-(id)valueForKey:(NSString *)key conformsToProtocol:(Protocol *)protocol;
/**
 * @brief Get the dictionary value for a specific key and return nil unless it responds to a specific selector
 *
 * @param key the key of the value
 * @param selector a selector that the value should respond to
 */
-(id)valueForKey:(NSString *)key expectingSelector:(SEL)selector;

-(NSData *)formUrlEncode;
@end
