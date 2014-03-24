//
//  KinveyImageView.m
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

#import "KinveyImageView.h"

@interface KinveyImageView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation KinveyImageView

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
    
    [[NSBundle mainBundle] loadNibNamed:@"KinveyImageView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
}

- (void)setKinveyID:(NSString *)kinveyID{
    
    _kinveyID = kinveyID;
    
    if (kinveyID.length) {
        [self.spinner startAnimating];
        
        //Kinvey: Laod image file
        [KCSFileStore downloadFile:kinveyID                         //File ID
                           options:@{KCSFileOnlyIfNewer : @(YES)}   //Get file from cache if can
                   completionBlock: ^(NSArray *downloadedResources, NSError *error) {
                       
                       if (error == nil) {
                           KCSFile* file = downloadedResources[0];
                           NSURL* fileURL = file.localURL;
                           UIImage* image = [UIImage imageWithContentsOfFile:[fileURL path]];
                           image = [self imageWithImage:image size:self.imageView.frame.size];
                           
                           //Return to main thread for update UI
                           dispatch_async(dispatch_get_main_queue(), ^{
                               self.imageView.image = image;
                               [self.spinner stopAnimating];
                               [self setNeedsDisplay];
                               [self setNeedsLayout];
                           });
                           
                       } else {
                           NSLog(@"Got an error: %@", error);
                       }
                   } progressBlock:nil];
    }else{
        self.imageView.image = nil;
    }
}

- (UIImage *)imageWithImage:(UIImage *)image size:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
