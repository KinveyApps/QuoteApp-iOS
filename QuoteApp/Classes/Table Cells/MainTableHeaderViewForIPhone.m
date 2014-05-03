//
//  MainTableHeaderViewForIPhone.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
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

#import "MainTableHeaderViewForIPhone.h"

@interface MainTableHeaderViewForIPhone ()

@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *disclosureLabel;

@end

@implementation MainTableHeaderViewForIPhone

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup{
    
    [[NSBundle mainBundle] loadNibNamed:@"MainTableHeaderViewForIPhone" owner:self options:nil];
    [self.contentView addSubview:self.view];
    self.view.frame = self.contentView.bounds;
}

- (void)setType:(HeaderViewMainTableType)type{
    
    _type = type;
    
    switch (_type) {
        
        //setup order type header
        case HeaderViewMainTableTypeOrder:{
            self.noLabel.text = LOC(MTVH_NO_ORDER);
            self.statusPriceLabel.text = LOC(MTVH_STATUS_ORDER);
            self.disclosureLabel.text = LOC(MTVH_MORE_ORDER);
        }break;
            
        //setup quote type header
        case HeaderViewMainTableTypeQuotes:{
            self.noLabel.text = LOC(MTVH_NO_QUOTE);
            self.statusPriceLabel.text = LOC(MTVH_PRICE_QUOTE);
            self.disclosureLabel.text = LOC(MTVH_MORE_ORDER);
        }break;
            
        default:
            break;
    }
}

@end
