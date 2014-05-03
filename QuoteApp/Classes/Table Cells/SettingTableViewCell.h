//
//  SettingTableViewCell.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 20.2.14.
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

#import <UIKit/UIKit.h>

@class SettingTableViewCell;

@protocol SettingTableViewCellDelegate <NSObject>

//call in UITextFieldDelegate method
- (void)valueTextFieldDidEndEditingWithValue:(NSString *)value sender:(SettingTableViewCell *)sender;

@end

@interface SettingTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@property (weak, nonatomic) id<SettingTableViewCellDelegate> delegate;

@end
