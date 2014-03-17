//
//  SettingTableViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 20.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

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
