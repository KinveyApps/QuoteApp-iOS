//
//  SettingTableViewCell.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 20.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingTableViewCell;

@protocol SettingTableViewCellDelegate <NSObject>

- (void)valueTextFieldDidEndEditingWithValue:(NSString *)value sender:(SettingTableViewCell *)sender;

@end

@interface SettingTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@property (weak, nonatomic) id<SettingTableViewCellDelegate> delegate;

@end
