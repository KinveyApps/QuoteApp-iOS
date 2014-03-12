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

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

#define RED_COLOR [UIColor colorWithRed:0.2196 green:0.0824 blue:0.0353 alpha:1.0]
#define TINT_COLOR [UIColor colorWithRed:0.9686 green:0.7176 blue:0.2353 alpha:1.0]
#define BAR_COLOR [UIColor colorWithRed:0.8549 green:0.3137 blue:0.1686 alpha:1.0]

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: RED_COLOR} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: TINT_COLOR} forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:TINT_COLOR];
    [[UITabBar appearance] setBarTintColor:BAR_COLOR];
    self.tabBar.translucent = NO;
    
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:0];
    UIImage *unselectedImage = [UIImage imageNamed:@"HomeNormal"];
    UIImage *selectedImage = [UIImage imageNamed:@"HomeSelected"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:1];
    unselectedImage = [UIImage imageNamed:@"HomeNormal"];
    selectedImage = [UIImage imageNamed:@"HomeSelected"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:2];
    unselectedImage = [UIImage imageNamed:@"BrowseNormal"];
    selectedImage = [UIImage imageNamed:@"BrowseSelected"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem = [self.tabBar.items objectAtIndex:3];
    unselectedImage = [UIImage imageNamed:@"NewQuoteNormal"];
    selectedImage = [UIImage imageNamed:@"NewQuoteSelected"];
    [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self.tabBar.items[0] setTitle:LOC(TBC_QUOTE)];
    [self.tabBar.items[1] setTitle:LOC(TBC_ORDER)];
    [self.tabBar.items[2] setTitle:LOC(TBC_PRODUCTS)];
    [self.tabBar.items[3] setTitle:LOC(TBC_QUOTE)];
}


@end
