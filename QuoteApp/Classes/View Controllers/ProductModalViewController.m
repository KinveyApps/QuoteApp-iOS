//
//  ProductModalViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.3.14.
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

#import "ProductModalViewController.h"
#import "ProductSubView.h"
#import "NewQuoteViewController.h"

#define SCROOLL_VIEW_INSETS_FOR_IPHONE 20
#define TEXT_VIEW_INSET 20
#define TEXT_VIEW_HEIGHT_SCALE_FACTOR 1.2
#define KINVEY_IMAGE_VIEW_ASPECT_RATIO 3 * 2
#define TEXT_VIEW_TOP_INSET 8
#define TAB_BAR_INDEX_OF_NEW_QUOTE_CONTROLLER 3

@interface ProductModalViewController ()

@property (strong, nonatomic) ProductSubView *detailSubView;

@end

@implementation ProductModalViewController


#pragma mark - Initialization

- (instancetype)init{
    self = [self initWithNibName:@"BaseModalViewController" bundle:nil];
    return self;
}


#pragma mark - Setters and Getters

- (void)setItem:(Product *)item{
    
    if (item) {
        _item = item;
        [self updateUI];
    }
}


#pragma mark - View Life Cycle

- (void)setupConstraints{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height;
    }else{
        self.widthScrollViewConstraint.constant = self.view.bounds.size.width - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
        self.heightScrollViewConstraint.constant = self.view.bounds.size.height - self.toolbar.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - SCROOLL_VIEW_INSETS_FOR_IPHONE * 2;
    }
}

-(UIView *)getDetailSubView{
    
    self.detailSubView = [[ProductSubView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    [self.rightButton setTitle:LOC(PHVC_BUTTON_NEW_QUOTE)];
    if (self.item) {
        [self updateUI];
    }
    return self.detailSubView;
}

- (void)updateUI{
    
    self.detailSubView.titleLabel.text = self.item.title;
    NSError *error = nil;
    NSAttributedString *description = [[NSAttributedString alloc] initWithData:[self.item.descriptions dataUsingEncoding:NSUTF8StringEncoding]
                                                                       options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                            documentAttributes:nil
                                                                         error:&error];
    if (!error) {
        self.detailSubView.descriptionTextView.attributedText = description;
    }
    CGFloat textViewWidht = self.widthScrollViewConstraint.constant - TEXT_VIEW_INSET * 2;
    
    CGSize size = [description boundingRectWithSize:CGSizeMake(textViewWidht, CGFLOAT_MAX)
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            context:nil].size;
    
    size.height = size.height * TEXT_VIEW_HEIGHT_SCALE_FACTOR;
    self.detailSubView.descriptionTextView.contentSize = size;
    self.detailSubView.imageWidthConstraint.constant = self.widthScrollViewConstraint.constant;
    self.detailSubView.imageHeightConstraint.constant = self.widthScrollViewConstraint.constant / KINVEY_IMAGE_VIEW_ASPECT_RATIO;
    CGRect frame = self.detailSubView.frame;
    frame.size.height = self.detailSubView.titleLabel.frame.size.height + TEXT_VIEW_TOP_INSET * 2 + self.detailSubView.imageHeightConstraint.constant + size.height;
    self.detailSubView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    self.detailSubView.kinveyImageView.kinveyID = self.item.imageID;
    
    self.detailSubView.descriptionTextView.scrollEnabled = NO;
}


#pragma mark - Actions

- (void)additionalButtonAction{
    
    UITabBarController *tabBarController = (UITabBarController *)self.presentingViewController;
    
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NewQuoteViewController *newQuoteViewController = (NewQuoteViewController *)tabBarController.viewControllers[TAB_BAR_INDEX_OF_NEW_QUOTE_CONTROLLER];
                                 if ([newQuoteViewController isKindOfClass:[NewQuoteViewController class]]) {
                                     newQuoteViewController.quote.product = self.item;
                                     tabBarController.selectedIndex = TAB_BAR_INDEX_OF_NEW_QUOTE_CONTROLLER;
                                 }
                             }];
}
@end
