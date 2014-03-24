//
//  QuoteOrderModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 13.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "QuoteOrderModalViewController.h"
#import "QuoteOrderSubView.h"

#define SCROLL_VIEW_WIDHT_FOR_IPAD 300
#define SCROLL_VIEW_HEIGHT_FOR_IPAD 400
#define SCROLL_VIEW_INSETS_FOR_IPHONE 20

@interface QuoteOrderModalViewController ()

@property (nonatomic, strong) QuoteOrderSubView *detailSubView;

@end

@implementation QuoteOrderModalViewController


#pragma mark - Initialization

- (instancetype)init{
    
    self = [self initWithNibName:@"BaseModalViewController"
                          bundle:nil];
    return self;
}


#pragma mark - Setters and Getters

- (void)setItem:(Quote *)item{
    _item = item;
    
    self.detailSubView.item = item;
    [self updateToolbarButtonTitle];
}


#pragma mark - View Life Cycle

- (void)setupConstraints{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widthScrollViewConstraint.constant = SCROLL_VIEW_WIDHT_FOR_IPAD;
        self.heightScrollViewConstraint.constant = SCROLL_VIEW_HEIGHT_FOR_IPAD;
    }else{
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - 2 * SCROLL_VIEW_INSETS_FOR_IPHONE;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 2 * SCROLL_VIEW_INSETS_FOR_IPHONE;
    }
}

-(UIView *)getDetailSubView{
    
    CGRect frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    self.detailSubView = [[QuoteOrderSubView alloc] initWithFrame:frame];
    
    if (self.item) {
        self.detailSubView.item = self.item;
        [self updateToolbarButtonTitle];
    }
    
    return self.detailSubView;
}

- (void)updateToolbarButtonTitle{
    
    if ([self.item isKindOfClass:[Order class]]) {
        [self.rightButton setTitle:LOC(DV_BUTTON_RECREATE_ORDER)];
    }else{
        [self.rightButton setTitle:LOC(DV_BUTTON_SUBMIT_ORDER)];
    }
}


#pragma mark - Actions

- (void)additionalButtonAction{
    
    Order *order = [[Order alloc] init];
    
    order.meta = [[KCSMetadata alloc] init];
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
                                   self.item = [orders firstObject];
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ORDER_CONFIRMATION_TITLE)
                                                                                   message:LOC(DV_MESSAGE_ORDER_CONFIRMATION_TEXT)
                                                                                  delegate:self
                                                                         cancelButtonTitle:LOC(OKAY)
                                                                         otherButtonTitles:nil];
                                   [alert show];
                               }
                           }
                           onFailure:^(NSError *error){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ERROR_CREATE_ORDER)
                                                                               message:error.localizedDescription
                                                                              delegate:nil
                                                                     cancelButtonTitle:LOC(OKAY)
                                                                     otherButtonTitles:nil];
                               [alert show];
                           }];
}

@end
