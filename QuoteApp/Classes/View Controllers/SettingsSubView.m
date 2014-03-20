//
//  SettingsSubView.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 6.3.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "SettingsSubView.h"
#import "SettingTableViewCell.h"

#define TABLE_VIEW_CELL_HEIGHT 44

@interface SettingsSubView () <UITableViewDataSource, SettingTableViewCellDelegate>

@property (strong, nonatomic) NSArray *userData;
@property (nonatomic) BOOL isEditModeTableView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UISwitch *emailConfirmationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pushLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailConfirmationLabel;
@end

@implementation SettingsSubView

#pragma mark - Initialisation

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
    [[NSBundle mainBundle] loadNibNamed:@"SettingsSubView" owner:self options:nil];
    [self addSubview:self.view];
    self.view.frame = self.bounds;
    self.tableView.dataSource = self;
    self.isEditModeTableView = NO;
    self.titleLabel.text = LOC(TBC_SETTINGS);
    self.pushLabel.text = LOC(SVC_PUSH_LABEL);
    self.emailConfirmationLabel.text = LOC(SVC_EMAIL_CONFIRMATION_LABEL);
    [self.editButton setTitle:LOC(EDIT) forState:UIControlStateNormal];
    self.emailConfirmationSwitch.on = [[[KCSUser activeUser] getValueForAttribute:USER_INFO_KEY_EMAIL_CONFIRMATION_ENABLE] boolValue];
    self.pushNotificationSwitch.on = [[[KCSUser activeUser] getValueForAttribute:USER_INFO_KEY_PUSH_NOTIFICATION_ENABLE] boolValue];
    self.tableView.scrollEnabled = NO;
    [self updateUserData];
}

#pragma mark - Setters and Getters

- (void)setUserData:(NSArray *)userData{
    _userData = userData;
    if ([self.userData[3] isEqualToString:@""]) {
        NSMutableArray *userData = [self.userData mutableCopy];
        userData[3] = [KCSUser activeUser].userId;
        self.userData = [userData copy];
    }
    [self.tableView reloadData];
}

- (void)updateUserData{
    KCSUser *user = [KCSUser activeUser];
    if (user) {
        
        NSMutableArray *userData = [NSMutableArray array];
        NSArray *keyArray = [self allUserInfoKey];
        
        for (int i = 0; i < keyArray.count; i++) {
            if ([user getValueForAttribute:keyArray[i]]) {
                [userData addObject:[user getValueForAttribute:keyArray[i]]];
            }else{
                if ([keyArray[i] isEqualToString:USER_INFO_KEY_EMAIL]) {
                    [userData addObject:user.email];
                }else{
                    [userData addObject:@""];
                }
            }
        }
        
        self.userData = [userData copy];
    }
}

#pragma mark - Actions

- (IBAction)pressEdit:(UIButton *)sender {
    self.isEditModeTableView = self.isEditModeTableView ? NO : YES;
    
    if (self.isEditModeTableView) {
        [self.editButton setTitle:LOC(DONE) forState:UIControlStateNormal];
    }else{
        [self.editButton setTitle:LOC(EDIT) forState:UIControlStateNormal];
        [self.spinner startAnimating];
        [self endInputIfNeed];
        [[DataHelper instance] saveUserWithInfo:[self userInfo]
                                      OnSuccess:^(NSArray *users){
                                          if (users.count) {
                                              [self.spinner stopAnimating];
                                          }
                                      }
                                      onFailure:^(NSError *error){
                                          [self.spinner stopAnimating];
                                      }];
    }
    [self.tableView reloadData];
}

- (IBAction)switchEmailPush {
    [self.spinner startAnimating];
    [[DataHelper instance] saveUserWithInfo:[self userInfo]
                                  OnSuccess:^(NSArray *users){
                                      if (users.count) {
                                          [self.spinner stopAnimating];
                                      }
                                  }
                                  onFailure:^(NSError *error){
                                      [self.spinner stopAnimating];
                                  }];
}

#pragma mark - Utils

- (void)endInputIfNeed{
    for (int i = 0; i < self.userData.count; i++) {
        SettingTableViewCell *cell = (SettingTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell.valueTextField isFirstResponder]) {
            [cell.valueTextField resignFirstResponder];
        }
    }
}

- (NSDictionary *)userInfo{
    NSString *value;
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *keyArray = [self allUserInfoKey];
    
    for (int i = 0; i < keyArray.count; i++) {
        value = (NSString *)self.userData[i];
        if (![value isEqualToString:@""]) {
            result[keyArray[i]] = value;
        }
    }
    
    [result setObject:[NSNumber numberWithBool:self.emailConfirmationSwitch.on]
               forKey:USER_INFO_KEY_EMAIL_CONFIRMATION_ENABLE];
    [result setObject:[NSNumber numberWithBool:self.pushNotificationSwitch.on]
               forKey:USER_INFO_KEY_PUSH_NOTIFICATION_ENABLE];
    
    return [result copy];
}

- (NSArray *)allUserInfoKey{
    return @[USER_INFO_KEY_CONTACT,
             USER_INFO_KEY_COMPANY,
             USER_INFO_KEY_SHIPING_ADDRESS,
             USER_INFO_KEY_ACCOUNT_NUMBER,
             USER_INFO_KEY_PHONE,
             USER_INFO_KEY_EMAIL
             ];
}

#pragma mark - TABLE VIEW
#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [[SettingTableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    cell.titleLabel.text = [self titleForCellWithKey:[self allUserInfoKey][indexPath.row]];
    NSString *value = (NSString *)self.userData[indexPath.row];
    if (![value isEqualToString:@""]) {
        cell.valueTextField.text = value;
    }
    cell.delegate = self;
    if (self.isEditModeTableView) {
        cell.valueTextField.enabled = YES;
    }else{
        cell.valueTextField.enabled = NO;
    }
    return cell;
}

#pragma mark - Utils

- (NSString *)titleForCellWithKey:(NSString *)key{
    if ([key isEqualToString:USER_INFO_KEY_CONTACT]) {
        return LOC(SVC_CELL_TITLE_CONTACT);
    }
    if ([key isEqualToString:USER_INFO_KEY_COMPANY]) {
        return LOC(SVC_CELL_TITLE_COMPANY);
    }
    if ([key isEqualToString:USER_INFO_KEY_SHIPING_ADDRESS]) {
        return LOC(SVC_CELL_TITLE_SHIPING_ADDRESS);
    }
    if ([key isEqualToString:USER_INFO_KEY_ACCOUNT_NUMBER]) {
        return LOC(SVC_CELL_TITLE_ACCOUNT_NUMBER);
    }
    if ([key isEqualToString:USER_INFO_KEY_PHONE]) {
        return LOC(SVC_CELL_TITLE_PHONE);
    }
    if ([key isEqualToString:USER_INFO_KEY_EMAIL]) {
        return LOC(SVC_CELL_TITLE_EMAIL);
    }
    return nil;
}

#pragma mark - SETTING TABLE VIEW CELL
#pragma mark - Delegate

- (void)valueTextFieldDidEndEditingWithValue:(NSString *)value sender:(SettingTableViewCell *)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSMutableArray *userData = [self.userData mutableCopy];
    userData[indexPath.row] = value;
    self.userData = [userData copy];
}

@end
