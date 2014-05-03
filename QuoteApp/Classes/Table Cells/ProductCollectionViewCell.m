//
//  ProductCollectionViewCell.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 3.3.14.
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
