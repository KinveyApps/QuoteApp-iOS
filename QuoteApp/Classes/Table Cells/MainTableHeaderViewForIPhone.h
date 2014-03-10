//
//  MainTableHeaderViewForIPhone.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableHeaderView.h"

@interface MainTableHeaderViewForIPhone : UITableViewHeaderFooterView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic) HeaderViewMainTableType type;
@end
