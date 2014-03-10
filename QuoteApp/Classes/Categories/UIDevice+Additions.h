//
//  UIDevice+Additions.h
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

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

/**
 @return YES if device support iPhone idiom
 */
- (BOOL)isIPhone;
/**
 @return YES if device support iPad idiom
 */
- (BOOL)isIPad;
/**
 @return YES if compiled for iOS simulator target
 */
- (BOOL)isSimulator;
/**
 @return YES(for iPhone and iPad) if scale of screen equal 2.0f
 */
- (BOOL)isRetina;
/**
 @return YES if height of screen equla 960 px = iPhone 4, 3GS, iPod with retina
 */
- (BOOL)isRetina3_5;
/**
 @return YES if height of screen equla 1136 px = iPhone 5
 */
- (BOOL)isRetina4;

#ifdef DEBUG

#warning DO NOT INCLUDE THESE IN APPSTORE BINARY!!!

/**
 @return Actual amount of free RAM in bytes
 */
- (double)getAvailableBytes;

/**
 @return Actual amount of free RAM in kilobytes
 */
- (double)getAvailableKiloBytes;

/**
 @return Actual amount of free RAM in megabytes
 */
- (double)getAvailableMegaBytes;

#endif

@end
