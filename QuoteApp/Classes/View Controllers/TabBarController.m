//
//  TabBarController.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 5.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (id)init{
    
    self = [super init];
    if (self) {
        // Custom initialization
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
    
    [self setTabBarItemAtIndex:0
             selectedImageName:@"HomeSelected"
           unselectedImageName:@"HomeNormal"];
    [self setTabBarItemAtIndex:1
             selectedImageName:@"HomeSelected"
           unselectedImageName:@"HomeNormal"];
    [self setTabBarItemAtIndex:2
             selectedImageName:@"BrowseSelected"
           unselectedImageName:@"BrowseNormal"];
    [self setTabBarItemAtIndex:3
             selectedImageName:@"NewQuoteSelected"
           unselectedImageName:@"NewQuoteNormal"];

    [self.tabBar.items[0] setTitle:LOC(TBC_QUOTE)];
    [self.tabBar.items[1] setTitle:LOC(TBC_ORDER)];
    [self.tabBar.items[2] setTitle:LOC(TBC_PRODUCTS)];
    [self.tabBar.items[3] setTitle:LOC(TBC_QUOTE)];
}

- (void)setTabBarItemAtIndex:(NSInteger)index selectedImageName:(NSString *)selectedImageName unselectedImageName:(NSString *)unselectedImageName{
    
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:index];
    UIImage *unselectedImage = [UIImage imageNamed:unselectedImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


@end
