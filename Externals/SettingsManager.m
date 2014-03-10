//
//  SideMenuViewController.h
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

#import "SettingsManager.h"
#import "SynthesizeSingleton.h"

#define kSettingAccountActivated    @"AccountActivated"
#define kSettingAlreadyLaunched     @"kSettingAlreadyLaunched"

@interface SettingsManager () 
    
@property(nonatomic, strong) NSUserDefaults * defaults;

@end

static SettingsManager * sharedSettingsManager;

@implementation SettingsManager
@synthesize defaults;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.defaults = [NSUserDefaults standardUserDefaults];
        
        if (![self isAlreadyLaunched]) {
            
            [self setDefaultSettings];
        }
    }
    return self;
}

- (void)dealloc
{
    self.defaults = nil;
}

#pragma mark -

+ (SettingsManager*) sharedSettingsManager {
    
    if (!sharedSettingsManager) {
        
        sharedSettingsManager = [SettingsManager new];
    }
    
    return sharedSettingsManager;
}

#pragma mark -

- (void) setDefaultSettings {
        
    [defaults setBool:YES forKey:kSettingAlreadyLaunched];
    [defaults synchronize];
}

- (BOOL) boolSetting: (NSString *) key {

    return [defaults boolForKey:key];
}

- (void) setBoolSetting: (NSString *) key forValue: (BOOL)value {
    
    [defaults setBool:value forKey:key];
}

- (NSString *) stringSetting: (NSString *) key {

    return [defaults stringForKey:key];
}

- (NSInteger) integerSetting: (NSString *)key {

    return [defaults integerForKey:key];
}

- (void) setObjectSetting: (NSString *)key forValue: (id)object {

    [defaults setObject:object forKey:key];
}

- (void) setIntegerSetting:(NSString *)key forValue:(NSInteger)value {

    [defaults setInteger:value forKey:key];
}

#pragma mark - 

- (BOOL) isAccountActivated {
    return [self boolSetting:kSettingAccountActivated];
}

- (void) setAccountActivated:(BOOL)value {
    [self setBoolSetting:kSettingAccountActivated forValue:value];
}

- (BOOL) isAlreadyLaunched {
    return [self boolSetting:kSettingAlreadyLaunched];
}

- (void) setAlreadyLaunched:(BOOL)value {
    [self setBoolSetting:kSettingAlreadyLaunched forValue:value];
}

@end
