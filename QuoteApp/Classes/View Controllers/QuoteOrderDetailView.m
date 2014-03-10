//
//  QuoteOrderDetailView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "QuoteOrderDetailView.h"
#import "QuoteOrderSubView.h"

#define SCROLL_VIEW_INSET_FOR_IPAD 60
#define BLUR_VIEW_WIDHT_FOR_IPAD 400
#define BLUR_VIEW_HEIGHT_FOR_IPAD 490
#define SCROLL_VIEW_INSET_FOR_IPHONE 5
#define BLUR_VIEW_INSET_FOR_IPHINE 40

@interface QuoteOrderDetailView ()

@property (strong, nonatomic) QuoteOrderSubView *detailSubView;

@end

@implementation QuoteOrderDetailView

#pragma mark - Initialisation

-(UIView *)getDetailSubView{
    CGRect frame = CGRectMake(0, 0, self.widhtConstraint.constant - self.leftConstraint.constant - self.rightConstraint.constant, self.scrollView.frame.size.height);
    self.detailSubView = [[QuoteOrderSubView alloc] initWithFrame:frame];
    return self.detailSubView;
}

- (void)setupConstraints{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widhtConstraint.constant = BLUR_VIEW_WIDHT_FOR_IPAD;
        self.heightConstrait.constant = BLUR_VIEW_HEIGHT_FOR_IPAD;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
    }else{
        self.widhtConstraint.constant = self.bounds.size.width - BLUR_VIEW_INSET_FOR_IPHINE;
        self.heightConstrait.constant = self.bounds.size.height - BLUR_VIEW_INSET_FOR_IPHINE;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
    }
}

#pragma mark - Setters and Getters

- (void)setItem:(Quote *)item{
    _item = item;
    self.detailSubView.item = item;
    if ([self.item isKindOfClass:[Order class]]) {
        self.numberButtonType = OneButtonWithAdditionalButtonDetailViewType;
    }else{
        self.numberButtonType = TwoButtonDetailViewType;
    }
}

#pragma mark - Actions

- (void)additionalButtonAction{
    Quote *quote = [[Quote alloc] init];
    [self.additionalButtonSpinner startAnimating];
    
    //change reference number
    NSInteger numberQuote = [self.item.referenceNumber substringFromIndex:2].integerValue;
    numberQuote++;
    quote.referenceNumber = [[self.item.referenceNumber substringToIndex:2] stringByAppendingString:[NSString stringWithFormat:@"%d", numberQuote]];
    
    quote.originator = self.item.originator;
    quote.activeUsers = self.item.activeUsers;
    quote.businessLogicScripts = self.item.businessLogicScripts;
    quote.scheduledBusinessLogic = self.item.scheduledBusinessLogic;
    quote.collaborators = self.item.collaborators;
    quote.backendEnvironments = self.item.backendEnvironments;
    quote.dataStorage = self.item.dataStorage;
    quote.businessLogicExecutionTimeLimit = self.item.businessLogicExecutionTimeLimit;
    quote.startSubscriptionDate = self.item.startSubscriptionDate;
    quote.totalPrice = self.item.totalPrice;
    quote.product = self.item.product;
    
    [[DataHelper instance] saveQuote:quote
                           OnSuccess:^(NSArray *quotes){
                               if (quotes.count) {
                                   self.item = quote;
                               }
                               [self.additionalButtonSpinner stopAnimating];
                           }
                           onFailure:^(NSError *error){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ERROR_CREATE_QUOTE)
                                                                               message:error.localizedDescription
                                                                              delegate:nil
                                                                     cancelButtonTitle:LOC(OKAY)
                                                                     otherButtonTitles:nil];
                               [alert show];
                               [self.additionalButtonSpinner stopAnimating];
                           }
     ];

}

- (void)leftButtonAction{
    Order *order = [[Order alloc] init];
    
    [self.leftButtonSpinner startAnimating];
    
    order.referenceNumber = self.item.referenceNumber;
    order.originator = self.item.originator;
    order.originator = self.item.originator;
    order.activeUsers = self.item.activeUsers;
    order.businessLogicScripts = self.item.businessLogicScripts;
    order.scheduledBusinessLogic = self.item.scheduledBusinessLogic;
    order.collaborators = self.item.collaborators;
    order.backendEnvironments = self.item.backendEnvironments;
    order.dataStorage = self.item.dataStorage;
    order.businessLogicExecutionTimeLimit = self.item.businessLogicExecutionTimeLimit;
    order.startSubscriptionDate = self.item.startSubscriptionDate;
    order.totalPrice = self.item.totalPrice;
    order.product = self.item.product;
    order.currentSubscription = STARTER_ORDER_SUBSCRIPTION;
    
    [[DataHelper instance] saveOrder:order
                           OnSuccess:^(NSArray *orders){
                               if (orders.count) {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ORDER_CONFIRMATION_TITLE)
                                                                                   message:LOC(DV_MESSAGE_ORDER_CONFIRMATION_TEXT)
                                                                                  delegate:self
                                                                         cancelButtonTitle:LOC(OKAY)
                                                                         otherButtonTitles:nil];
                                   [alert show];
                               }
                               [self.leftButtonSpinner stopAnimating];
                           }
                           onFailure:^(NSError *error){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ERROR_CREATE_ORDER)
                                                                               message:error.localizedDescription
                                                                              delegate:nil
                                                                     cancelButtonTitle:LOC(OKAY)
                                                                     otherButtonTitles:nil];
                               [alert show];
                               [self.leftButtonSpinner stopAnimating];
                           }
     ];

}

- (void)rightButtonAction{
    [self removeFromSuperview];
}

- (void)centerButtonAction{
    [self removeFromSuperview];
}

@end
