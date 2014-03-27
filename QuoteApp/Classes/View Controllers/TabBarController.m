//
//  TabBarController.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 5.2.14.
/**
 * Copyright (c) 2014 Kinvey Inc. *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at *
 * http://www.apache.org/licenses/LICENSE-2.0 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License. *
 */

#import "TabBarController.h"

@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: RED_COLOR}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: TINT_COLOR}
                                             forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:TINT_COLOR];
    [[UITabBar appearance] setBarTintColor:BAR_COLOR];
    self.tabBar.translucent = NO;
    
    //Set Tab Bar Items Image for selected and normal state
    [self setTabBarItemAtIndex:0
             selectedImageName:@"QuotesSelected"
           unselectedImageName:@"QuotesNormal"];
    [self setTabBarItemAtIndex:1
             selectedImageName:@"OrdersSelected"
           unselectedImageName:@"OrdersNormal"];
    [self setTabBarItemAtIndex:2
             selectedImageName:@"ProductsSelected"
           unselectedImageName:@"ProductsNormal"];
    [self setTabBarItemAtIndex:3
             selectedImageName:@"NewQuoteSelected"
           unselectedImageName:@"NewQuoteNormal"];
    [self setTabBarItemAtIndex:4
             selectedImageName:@"AboutSelected"
           unselectedImageName:@"AboutNormal"];

    [self.tabBar.items[0] setTitle:LOC(TBC_QUOTE)];
    [self.tabBar.items[1] setTitle:LOC(TBC_ORDER)];
    [self.tabBar.items[2] setTitle:LOC(TBC_PRODUCTS)];
    [self.tabBar.items[3] setTitle:LOC(TBC_NEW_QUOTES)];
    [self.tabBar.items[4] setTitle:LOC(TBC_ABOUT)];
}

- (void)setTabBarItemAtIndex:(NSInteger)index selectedImageName:(NSString *)selectedImageName unselectedImageName:(NSString *)unselectedImageName{
    
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:index];
    UIImage *unselectedImage = [UIImage imageNamed:unselectedImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


@end
