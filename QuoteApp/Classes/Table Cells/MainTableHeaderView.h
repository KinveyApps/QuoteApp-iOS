//
//  MainTableHeaderView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 11.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    HeaderViewMainTableTypeOrder = 0,
    HeaderViewMainTableTypeQuotes = 1
}HeaderViewMainTableType;

@interface MainTableHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic) HeaderViewMainTableType type;

@end
