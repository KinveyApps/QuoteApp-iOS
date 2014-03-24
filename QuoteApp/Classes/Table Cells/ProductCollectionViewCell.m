//
//  ProductCollectionViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 3.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "KinveyImageView.h"

@interface ProductCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet KinveyImageView *kinveyImageView;


@end

@implementation ProductCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ProductCollectionViewCell" owner:self options:nil];
		[self.contentView addSubview:self.view];
		self.view.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setItem:(Product *)item{
    
    if (item) {
        _item = item;
        self.titleLabel.text = item.title;
        self.kinveyImageView.kinveyID = @"";
        self.kinveyImageView.kinveyID = item.thumbnailID;
    }
}

@end
