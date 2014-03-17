//
//  MainTableHeaderView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 11.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "MainTableHeaderView.h"

@interface MainTableHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipaDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *disclosureLabel;


@end

@implementation MainTableHeaderView

- (id)initWithFrame:(CGRect)frame
{
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
            self.shipaDateLabel.text = LOC(MTVH_START_SUBSCRIPTION_DATE);
            self.statusPriceLabel.text = LOC(MTVH_STATUS_ORDER);
            self.disclosureLabel.text = LOC(MTVH_MORE_ORDER);
        }break;
            
        case HeaderViewMainTableTypeQuotes:{
            self.titleLabel.text = LOC(MTVH_TITLE_QUOTE);
            self.dateLabel.text = LOC(MTVH_DATE_QUOTE);
            self.noLabel.text = LOC(MTVH_NO_QUOTE);
            self.shipaDateLabel.text = LOC(MTVH_START_SUBSCRIPTION_DATE);
            self.statusPriceLabel.text = LOC(MTVH_PRICE_QUOTE);
            self.disclosureLabel.text = LOC(MTVH_MORE_QUOTE);
        }break;
            
        default:
            break;
    }
}

@end
