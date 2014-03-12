//
//  ProductViewCellForIPhone.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "ProductViewCellForIPhone.h"
#import "KinveyImageView.h"

@interface ProductViewCellForIPhone ()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet KinveyImageView *kinveyImageView;

@end

@implementation ProductViewCellForIPhone

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ProductViewCellForIPhone" owner:self options:nil];
		[self.contentView addSubview:self.view];
        [self.descriptionView setClipsToBounds:YES];
		self.view.frame = self.contentView.bounds;
        self.descriptionView.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(Product *)item{
    if (item) {
        _item = item;
        self.productNameLabel.text = item.title;
        NSError *error = nil;
        NSAttributedString *description = [[NSAttributedString alloc] initWithData:[item.description dataUsingEncoding:NSUTF8StringEncoding]
                                                                           options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                documentAttributes:nil
                                                                             error:&error];
        self.descriptionLabel.text = description.string;
        [self.descriptionLabel sizeToFit];
        //self.heightDescriptionLabel.constant = self.descriptionLabel.frame.size.height;
        self.kinveyImageView.kinveyID = item.thumbnailID;
    }
    
}

@end
