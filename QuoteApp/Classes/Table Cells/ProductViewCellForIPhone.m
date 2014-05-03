//
//  ProductViewCellForIPhone.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
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

- (void)setItem:(Product *)item{
    
    if (item) {
        _item = item;
        self.productNameLabel.text = item.title;
        
        //contvert HTML data to NSAttributed string
        NSError *error = nil;
        NSAttributedString *description = [[NSAttributedString alloc] initWithData:[item.description dataUsingEncoding:NSUTF8StringEncoding]
                                                                           options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                documentAttributes:nil
                                                                             error:&error];
        if (!error) {
            self.descriptionLabel.text = description.string;
            [self.descriptionLabel sizeToFit];
        }
        
        self.kinveyImageView.kinveyID = item.thumbnailID;
    }
}

@end
