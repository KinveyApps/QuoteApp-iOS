//
//  ComboBoxNewQuoteTableViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 17.2.14.
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

#import "ComboBoxNewQuoteTableViewCell.h"

@interface ComboBoxNewQuoteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ComboBoxNewQuoteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ComboBoxNewQuoteTableViewCell" owner:self options:nil];
		[self.contentView addSubview:self.view];
		self.view.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    switch (index) {
        case ProductCellIndex:{
            self.textField.placeholder = PLACEHOLDER_PRODUCT_TEXT_FIELD;
            [self.button setImage:[UIImage imageNamed:IMAGE_NAME_LIST_BUTTON] forState:UIControlStateNormal];
            self.button.hidden = NO;
        }break;
        case ActiveUserCellIndex:{
            self.textField.placeholder = PLACEHOLDER_ACTIVE_USER_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case BusinessLogicScriptsCellIndex:{
            self.textField.placeholder = PLACEHOLDER_BUSINESS_LOGIC_SCRIPTS_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case ScheduledBusinessLogicCellIndex:{
            self.textField.placeholder = PLACEHOLDER_SCHEDULED_BUSINESS_LOGIC_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case CollaboratorsCellIndex:{
            self.textField.placeholder = PLACEHOLDER_COLLABORATORS_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case BackendEnviromentsCellIndex:{
            self.textField.placeholder = PLACEHOLDER_BACKEND_ENVIROMENTS_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case DataStoregeCellIndex:{
            self.textField.placeholder = PLACEHOLDER_DATA_STOREGE_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case BusinessLogicExecutionTimeLimitCellIndex:{
            self.textField.placeholder = PLACEHOLDER_BUSINESS_LOGIC_EXECUTION_TIME_LIMIT_TEXT_FIELD;
            self.textField.enabled = YES;
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.button.hidden = YES;
        }break;
        case StartSubscriptionDateCellIndex:{
            self.textField.placeholder = PLACEHOLDER_START_SUBSCRIPTION_DATE_TEXT_FIELD;
            [self.button setImage:[UIImage imageNamed:IMAGE_NAME_CALENDAR_BUTTON] forState:UIControlStateNormal];
            self.button.hidden = NO;
        }break;
            
        default:
            break;
    }
}

@end
