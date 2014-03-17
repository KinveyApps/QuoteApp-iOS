//
//  MainTableViewCellForIPhone.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

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
