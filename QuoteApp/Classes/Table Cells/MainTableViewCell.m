//
//  MainTableViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 11.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusPriceLabel;

@end

@implementation MainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil];
		[self.contentView addSubview:self.view];
		self.view.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(id)item{
    if (item) {
        _item = item;
        NSDateFormatter *formatter = [DataHelper instance].formatter;
        
        if ([item isKindOfClass:[Order class]]) {
            
            Order *order = (Order *)item;
            self.dateLabel.text = [formatter stringFromDate:order.meta.creationTime];
            self.noLabel.text = order.referenceNumber;
            self.shipDateLabel.text = [formatter stringFromDate:order.startSubscriptionDate];
            self.statusPriceLabel.text = [order statusDescription];
            
        }else if ([item isKindOfClass:[Quote class]]) {
            
            Quote *quote = (Quote *)item;
            self.dateLabel.text = [formatter stringFromDate:quote.meta.creationTime];
            self.noLabel.text = quote.referenceNumber;
            self.shipDateLabel.text = [formatter stringFromDate:quote.startSubscriptionDate];
            self.statusPriceLabel.text = quote.totalPrice;
            
        }
    }
}

@end
