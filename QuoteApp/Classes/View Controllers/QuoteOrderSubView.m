//
//  QuoteOrderSubView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "QuoteOrderSubView.h"

@interface QuoteOrderSubView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *referenceNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *alloyLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperLebel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxODLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestLbsYieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseFabPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;

@end

@implementation QuoteOrderSubView

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
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
    [[NSBundle mainBundle] loadNibNamed:@"QuoteOrderSubView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    
}

#pragma mark - Setters and Getters

- (void)setItem:(Quote *)item{
    if (item) {
        _item = item;
        if (item.product) self.productTitleLabel.text = [LOC(DV_PRODUCT_TITLE) stringByAppendingString:item.product.title];
        if (item.referenceNumber) self.referenceNumberLabel.text = [LOC(DV_REFERENCE_NUMBER) stringByAppendingString:item.referenceNumber];
        if (item.activeUsers) self.alloyLabel.text = [LOC(DV_ALLOY) stringByAppendingString:item.activeUsers];
        if (item.businessLogicScripts) self.temperLebel.text = [LOC(DV_TEMPER) stringByAppendingString:item.businessLogicScripts];
        if (item.scheduledBusinessLogic) self.widthLabel.text = [LOC(DV_WIDTH) stringByAppendingString:item.scheduledBusinessLogic];
        if (item.collaborators) self.finishLabel.text = [LOC(DV_FINISH) stringByAppendingString:item.collaborators];
        if (item.backendEnvironments) self.maxIDLabel.text = [LOC(DV_MAX_ID) stringByAppendingString:item.backendEnvironments];
        if (item.dataStorage) self.maxODLabel.text = [LOC(DV_MAX_OD) stringByAppendingString:item.dataStorage];
        if (item.businessLogicExecutionTimeLimit) self.requestLbsYieldLabel.text = [LOC(DV_REQUESTED_YIELD) stringByAppendingString:item.businessLogicExecutionTimeLimit];
        if (item.totalPrice) self.baseFabPriceLabel.text = [LOC(DV_TOTAL_PRICE) stringByAppendingString:item.totalPrice];
        if (item.startSubscriptionDate) self.shipDateLabel.text = [LOC(DV_FAB_PRICE) stringByAppendingString:[[DataHelper instance].formatter stringFromDate:item.startSubscriptionDate]];
        
        if ([self.item isKindOfClass:[Order class]]) {
            self.titleLabel.text = LOC(DV_ORDER_TITLE);
        }else{
            self.titleLabel.text = LOC(DV_QUOTE_TITLE);
        }
    }
}

@end
