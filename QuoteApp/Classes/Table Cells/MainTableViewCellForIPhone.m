//
//  MainTableViewCellForIPhone.m
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

#import "MainTableViewCellForIPhone.h"

@interface MainTableViewCellForIPhone ()
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPriceLabel;
@end

@implementation MainTableViewCellForIPhone

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCellForIPhone" owner:self options:nil];
		[self.contentView addSubview:self.view];
		self.view.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setItem:(id)item{
    
    if (item) {
        _item = item;
        
        if ([item isKindOfClass:[Order class]]) {
            
            Order *order = (Order *)item;
            self.noLabel.text = order.referenceNumber;
            self.statusPriceLabel.text = [order statusDescription];
            
        }else if ([item isKindOfClass:[Quote class]]) {
            
            Quote *quote = (Quote *)item;
            self.noLabel.text = quote.referenceNumber;
            self.statusPriceLabel.text = quote.totalPrice;
            
        }
    }
}

@end
