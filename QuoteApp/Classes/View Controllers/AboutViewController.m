//
//  AboutViewController.m
//  QuoteSample
//
//  Created by Pavel Vilbik on 27.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "AboutViewController.h"
#import "SettingModalViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topBarView.backgroundColor = BAR_COLOR;
    self.titleLable.text = LOC(AVC_TITLE);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.textView.textContainerInset = UIEdgeInsetsMake(250, 100, 250, 100);
        self.textView.font = [UIFont systemFontOfSize:20];

    }else{
        self.textView.textContainerInset = UIEdgeInsetsZero;
        self.textView.font = [UIFont systemFontOfSize:15];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressSettings {
    
    SettingModalViewController *mv = [[SettingModalViewController alloc] init];
    mv.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:mv
                       animated:YES
                     completion:nil];
}

@end
