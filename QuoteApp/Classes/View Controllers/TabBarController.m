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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tabBar.items[0] setTitle:LOC(TBC_QUOTE)];
    [self.tabBar.items[1] setTitle:LOC(TBC_ORDER)];
    [self.tabBar.items[2] setTitle:LOC(TBC_PRODUCTS)];
    [self.tabBar.items[3] setTitle:LOC(TBC_QUOTE)];
}


@end
