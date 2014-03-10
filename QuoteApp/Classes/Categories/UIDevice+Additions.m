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

#import "UIDevice+Additions.h"

#ifdef DEBUG

#include <sys/sysctl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

#endif

@implementation UIDevice (Additions)

- (BOOL)isIPhone {
    
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

- (BOOL)isIPad {
    
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

- (BOOL)isSimulator {
#if TARGET_IPHONE_SIMULATOR
	return YES;
#else
	return NO;
#endif
}

- (BOOL)isRetina {
    
    return ([[UIScreen mainScreen] respondsToSelector: @selector(scale)] && [UIScreen mainScreen].scale == 2.0f);
}

- (BOOL)isRetina3_5 {
    
    BOOL result = NO;
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            
            CGSize size = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            size = CGSizeMake(size.width * scale, size.height * scale);
            
            result = (size.height == 960);
        }
    }
	
	return result;
}

- (BOOL)isRetina4 {
    
    BOOL result = NO;
    
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            
            CGSize size = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            size = CGSizeMake(size.width * scale, size.height * scale);
            
            result = (size.height == 1136);
        }
    }
	
	return result;
}

#ifdef DEBUG

- (double)getAvailableBytes {
    
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return (vm_page_size * vmStats.free_count);
}

- (double)getAvailableKiloBytes {
    
    return [self getAvailableBytes] / 1024.0;
}

- (double) getAvailableMegaBytes {
    
    return [self getAvailableKiloBytes] / 1024.0;
}

#endif

@end