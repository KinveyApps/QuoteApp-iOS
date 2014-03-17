//
//  ProductTableViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 14.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "ProductTableViewCell.h"
#import <KinveyKit/KinveyKit.h>
#import "KinveyImageView.h"

@interface ProductTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet KinveyImageView *kinveyImageView;


@end

@implementation ProductTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
		[self.contentView addSubview:self.view];
        [self.descriptionView setClipsToBounds:YES];
		self.view.frame = self.contentView.bounds;
        self.descriptionView.layer.cornerRadius = 5.0f;
    }
    return self;
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
        if (!error) {
            self.descriptionLabel.attributedText = description;
            [self.descriptionLabel sizeToFit];
        }
        
        self.kinveyImageView.kinveyID = item.thumbnailID;
    }
    
}

@end
