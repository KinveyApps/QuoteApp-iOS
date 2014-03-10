//
//  ProductsDetailView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 5.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "ProductsDetailView.h"
#import "ProductSubView.h"

#define SCROLL_VIEW_INSET_FOR_IPAD 0
#define BLUR_VIEW_WIDHT_FOR_IPAD 570
#define BLUR_VIEW_HEGHT_SCALE_FACTOR_FOR_IPAD 0.7
#define SCROLL_VIEW_INSET_FOR_IPHONE 0
#define BLUR_VIEW_INSET_FOR_IPHINE 40
#define TEXT_VIEW_INSET 20
#define TEXT_VIEW_HEIGHT_SCALE_FACTOR 1.2
#define KINVEY_IMAGE_VIEW_ASPECT_RATIO 3 * 2
#define TEXT_VIEW_TOP_INSET 8

@interface ProductsDetailView ()

@property (strong, nonatomic) ProductSubView *detailSubView;

@end

@implementation ProductsDetailView

#pragma mark - Initialisation

-(UIView *)getDetailSubView{
    self.detailSubView = [[ProductSubView alloc] initWithFrame:CGRectMake(0, 0, self.widhtConstraint.constant - self.leftConstraint.constant - self.rightConstraint.constant, self.scrollView.frame.size.height)];
    return self.detailSubView;
}

- (void)setupConstraints{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.widhtConstraint.constant = BLUR_VIEW_WIDHT_FOR_IPAD;
        self.heightConstrait.constant = self.frame.size.height * BLUR_VIEW_HEGHT_SCALE_FACTOR_FOR_IPAD;
        self.topConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPAD;
    }else{
        self.widhtConstraint.constant = self.bounds.size.width - BLUR_VIEW_INSET_FOR_IPHINE;
        self.heightConstrait.constant = self.bounds.size.height - BLUR_VIEW_INSET_FOR_IPHINE;
        self.topConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
        self.leftConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
        self.rightConstraint.constant = SCROLL_VIEW_INSET_FOR_IPHONE;
    }
}

#pragma mark - Setters and Getters

- (void)setItem:(Product *)item{
    if (item) {
        _item = item;
        self.numberButtonType = OneButtonDetailViewType;
        self.detailSubView.titleLabel.text = item.title;
        NSError *error = nil;
        NSAttributedString *description = [[NSAttributedString alloc] initWithData:[item.description dataUsingEncoding:NSUTF8StringEncoding]
                                                                           options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                documentAttributes:nil
                                                                             error:&error];
        self.detailSubView.descriptionTextView.attributedText = description;
        CGFloat textViewWidht = self.widhtConstraint.constant - self.leftConstraint.constant - self.rightConstraint.constant - TEXT_VIEW_INSET * 2;
        CGSize size = [description boundingRectWithSize:CGSizeMake(textViewWidht, CGFLOAT_MAX)
                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                context:nil].size;
        size.height = size.height * TEXT_VIEW_HEIGHT_SCALE_FACTOR;
        self.detailSubView.descriptionTextView.contentSize = size;
        self.detailSubView.imageWidthConstraint.constant = self.widhtConstraint.constant;
        self.detailSubView.imageHeightConstraint.constant = self.widhtConstraint.constant / KINVEY_IMAGE_VIEW_ASPECT_RATIO;
        CGRect frame = self.detailSubView.frame;
        frame.size.height = self.detailSubView.titleLabel.frame.size.height + TEXT_VIEW_TOP_INSET * 2 + self.detailSubView.imageHeightConstraint.constant + size.height;
        self.detailSubView.frame = frame;
        self.scrollView.contentSize = frame.size;
        self.detailSubView.kinveyImageView.kinveyID = item.imageID;
        self.detailSubView.descriptionTextView.scrollEnabled = NO;
    }
}

#pragma mark - Actions

- (void)centerButtonAction{
    [self removeFromSuperview];
}


@end
