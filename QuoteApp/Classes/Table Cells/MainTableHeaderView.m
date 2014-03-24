//
//  MainTableHeaderView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 11.2.14.
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

#import "MainTableHeaderView.h"

@interface MainTableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *startSubscriptionDate;
@property (weak, nonatomic) IBOutlet UILabel *statusPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *disclosureLabel;


@end

@implementation MainTableHeaderView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MainTableHeaderView" owner:self options:nil];
		[self.contentView addSubview:self.view];
		self.view.frame = self.contentView.bounds;
    }
    
    return self;
}

- (void)setType:(HeaderViewMainTableType)type{
    
    _type = type;
    
    switch (_type) {
            
        case HeaderViewMainTableTypeOrder:{
            self.titleLabel.text = LOC(MTVH_TITLE_ORDER);
            self.dateLabel.text = LOC(MTVH_DATE_ORDER);
            self.noLabel.text = LOC(MTVH_NO_ORDER);
            self.startSubscriptionDate.text = LOC(MTVH_START_SUBSCRIPTION_DATE);
            self.statusPriceLabel.text = LOC(MTVH_STATUS_ORDER);
            self.disclosureLabel.text = LOC(MTVH_MORE_ORDER);
        }break;
            
        case HeaderViewMainTableTypeQuotes:{
            self.titleLabel.text = LOC(MTVH_TITLE_QUOTE);
            self.dateLabel.text = LOC(MTVH_DATE_QUOTE);
            self.noLabel.text = LOC(MTVH_NO_QUOTE);
            self.startSubscriptionDate.text = LOC(MTVH_START_SUBSCRIPTION_DATE);
            self.statusPriceLabel.text = LOC(MTVH_PRICE_QUOTE);
            self.disclosureLabel.text = LOC(MTVH_MORE_QUOTE);
        }break;
            
        default:
            break;
    }
}

@end
