//
//  KinveyImageView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "KinveyImageView.h"

@interface KinveyImageView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation KinveyImageView

- (id)initWithFrame:(CGRect)frame
{
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
        [KCSFileStore downloadFile:kinveyID
                           options:@{KCSFileOnlyIfNewer : @(YES)}
                   completionBlock: ^(NSArray *downloadedResources, NSError *error) {
                       
                       if (error == nil) {
                           KCSFile* file = downloadedResources[0];
                           NSURL* fileURL = file.localURL;
                           UIImage* image = [UIImage imageWithContentsOfFile:[fileURL path]]; //note this blocks for awhile
                           image = [self imageWithImage:image size:self.imageView.frame.size];
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
