//
//  SettingTableViewCell.m
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

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SettingsTableViewCell" owner:self options:nil];
		[self.contentView addSubview:self.view];
        self.valueTextField.delegate = self;
        self.view.frame = self.contentView.bounds;
    }
    
    return self;
}

#pragma mark - TEXT FIELD
#pragma mark - Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.delegate valueTextFieldDidEndEditingWithValue:textField.text sender:self];
}

@end
