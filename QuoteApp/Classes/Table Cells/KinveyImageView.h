//
//  KinveyImageView.h
//  QuoteApp
//
//  Created by Pavel Vilbik on 4.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KinveyImageView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) NSString *kinveyID;
@end
