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

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

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
    
    //configure cell by index
    switch (index) {
            
        case ProductCellIndex:{
            [self setupCellWithImageName:IMAGE_NAME_LIST_BUTTON
                          andPlaceholder:PLACEHOLDER_PRODUCT_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:NO];
        }break;
            
        case ActiveUserCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_ACTIVE_USER_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case BusinessLogicScriptsCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_BUSINESS_LOGIC_SCRIPTS_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case ScheduledBusinessLogicCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_SCHEDULED_BUSINESS_LOGIC_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case CollaboratorsCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_COLLABORATORS_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case BackendEnviromentsCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_BACKEND_ENVIROMENTS_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case DataStoregeCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_DATA_STOREGE_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case BusinessLogicExecutionTimeLimitCellIndex:{
            [self setupCellWithImageName:nil
                          andPlaceholder:PLACEHOLDER_BUSINESS_LOGIC_EXECUTION_TIME_LIMIT_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:YES];
        }break;
            
        case StartSubscriptionDateCellIndex:{
            [self setupCellWithImageName:IMAGE_NAME_CALENDAR_BUTTON
                          andPlaceholder:PLACEHOLDER_START_SUBSCRIPTION_DATE_TEXT_FIELD
                         andKeyboardType:UIKeyboardTypeNumbersAndPunctuation
                               isDigital:NO];
        }break;
            
        default:
            break;
    }
}

- (void)setupCellWithImageName:(NSString *)imageName andPlaceholder:(NSString *)placeholder andKeyboardType:(UIKeyboardType)keyboardType isDigital:(BOOL)isDigital{
    
    if (isDigital) {
        self.minusButton.hidden = NO;
        self.plusButton.hidden = NO;
        self.image.hidden = YES;
        self.textField.enabled = NO;
    }else{
        if (imageName.length) {
            self.image.image = [UIImage imageNamed:imageName];
            self.image.hidden = NO;
            self.textField.enabled = NO;
        }else{
            self.textField.enabled = YES;
            self.textField.keyboardType = keyboardType;
            self.image.hidden = YES;
        }
    }
    
    
    self.textField.placeholder = placeholder;
    self.title.text = [placeholder stringByReplacingOccurrencesOfString:@" (required)" withString:@""];
}

- (IBAction)addValue:(UIButton *)sender {
    NSInteger currentValue = [self.textField.text integerValue];
    
    currentValue ++;
    
    self.textField.text = [NSString stringWithFormat:@"%ld", (long)currentValue];
    [self.textField.delegate textField:self.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:nil];
}

- (IBAction)decreaseValue:(UIButton *)sender {
    
    NSInteger currentValue = [self.textField.text integerValue];
    
    currentValue --;
    
    self.textField.text = [NSString stringWithFormat:@"%ld", currentValue > 0 ? (long)currentValue : 0];
    [self.textField.delegate textField:self.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:nil];
}

@end
