//
//  QuoteOrderSubView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
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

#import "QuoteOrderSubView.h"

@interface QuoteOrderSubView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *referenceNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *activeUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLogicScriptsLebel;
@property (weak, nonatomic) IBOutlet UILabel *scheduledBusinessLogicLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *backendEnvironmentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataStorageLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLogicExecutionTimeLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *startSubscriptionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;

@end

@implementation QuoteOrderSubView

#pragma mark - Initialisation

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
    
    [[NSBundle mainBundle] loadNibNamed:@"QuoteOrderSubView"
                                  owner:self
                                options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
}

#pragma mark - Setters and Getters

- (void)setItem:(Quote *)item{
    
    if (item) {
        _item = item;
        
        if (item.product) self.productTitleLabel.text = [LOC(DV_PRODUCT_TITLE) stringByAppendingString:item.product.title];
        if (item.referenceNumber) self.referenceNumberLabel.text = [LOC(DV_REFERENCE_NUMBER) stringByAppendingString:item.referenceNumber];
        if (item.activeUsers) self.activeUserLabel.text = [LOC(DV_ACTIVE_USER) stringByAppendingString:item.activeUsers];
        if (item.businessLogicScripts) self.businessLogicScriptsLebel.text = [LOC(DV_BUSINESS_LOGIC_SCRIPTS) stringByAppendingString:item.businessLogicScripts];
        if (item.scheduledBusinessLogic) self.scheduledBusinessLogicLabel.text = [LOC(DV_SCHEDULED_BUSINESS_LOGIC) stringByAppendingString:item.scheduledBusinessLogic];
        if (item.collaborators) self.collaboratorsLabel.text = [LOC(DV_COLLABORATORS) stringByAppendingString:item.collaborators];
        if (item.backendEnvironments) self.backendEnvironmentsLabel.text = [LOC(DV_BACKEND_ENVIRONMENTS) stringByAppendingString:item.backendEnvironments];
        if (item.dataStorage) self.dataStorageLabel.text = [LOC(DV_DATA_STORAGE) stringByAppendingString:item.dataStorage];
        if (item.businessLogicExecutionTimeLimit) self.businessLogicScriptsLebel.text = [LOC(DV_BUSINESS_EXECUTION_TIME_LIMIT) stringByAppendingString:item.businessLogicExecutionTimeLimit];
        if (item.totalPrice) self.totalCostLabel.text = [LOC(DV_TOTAL_COST) stringByAppendingString:item.totalPrice];
        if (item.startSubscriptionDate) self.startSubscriptionDateLabel.text = [LOC(DV_START_SUBSCRIPTION_DATE) stringByAppendingString:[[DataHelper instance].formatter stringFromDate:item.startSubscriptionDate]];
        
        if ([self.item isKindOfClass:[Order class]]) {
            self.titleLabel.text = LOC(DV_ORDER_TITLE);
        }else{
            self.titleLabel.text = LOC(DV_QUOTE_TITLE);
        }
    }
}

@end
