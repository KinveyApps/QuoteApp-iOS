//
//  QuoteViewController.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 5.2.14.
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

#import "NewQuoteViewController.h"
#import "ComboBoxNewQuoteTableViewCell.h"
#import "Quote.h"
#import "DataHelper.h"
#import "QuoteOrderModalViewController.h"
#import "SettingModalViewController.h"

#define PICKER_VIEW_HEIGHT 216
#define COMBOBOX_NEW_QUOTE_CELL_HEGHT 60
#define TABLE_VIEW_ROW_COUNT 9
#define COMBOBOX_NEW_QUOTE_CELL_WIDTH 300
#define BUTTON_CORNER_RADIUS 5.0f
#define TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_SHOW_KEYBOARD 64
#define TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_HIDE_KEYBOARD 100
#define BOTTOM_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_HIDE_KEYBOARD 20


@interface NewQuoteViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic) NSInteger countTableViewRows;
@property (strong, nonatomic) NSIndexPath *pickerIndexPath;
@property (strong, nonatomic) NSArray *pickerItem;
@property (strong, nonatomic) NSArray *products;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) QuoteOrderModalViewController *detailView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) UITextField *activeTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *betweenButtonTableViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UILabel *titleTopBarLable;

@end

@implementation NewQuoteViewController


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    [[NSBundle mainBundle] loadNibNamed:@"NewQuoteViewController" owner:self options:nil];

    [self.titleLabel setText:LOC(NQV_TITLE)];
    self.titleTopBarLable.text = LOC(NQV_TOP_BAR_TITLE);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.topConstraint.constant = TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_SHOW_KEYBOARD;
    }else{
        self.topConstraint.constant = TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_HIDE_KEYBOARD;
    }
}


#pragma mark - Geters and Setters

- (Quote *)quote{
    if (!_quote) {
        _quote = [[Quote alloc] init];
    }
    return _quote;
}


#pragma mark - View Life Cicly

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.countTableViewRows = TABLE_VIEW_ROW_COUNT;
    
    //Load all data from Product collection
    [[DataHelper instance] loadProductsUseCache:YES
                              containtSubstinrg:nil
                                      OnSuccess:^(NSArray *products){
                                          self.products = products;
                                      }
                                      onFailure:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self.submitButton setTitle:LOC(NQV_BUTTON_SUBMIT) forState:UIControlStateNormal];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.tableViewWidthConstraint.constant = COMBOBOX_NEW_QUOTE_CELL_WIDTH;
    }

    self.topBarView.backgroundColor = BAR_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.submitButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notification

- (void)keyboardShow:(NSNotification *)notification{
    
    CGRect keyboardOriginFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardRelativeFrame = [self.view convertRect:keyboardOriginFrame fromView:nil];
    
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
                         if ((orientation == UIDeviceOrientationLandscapeLeft)||(orientation == UIDeviceOrientationLandscapeRight)) {
                             self.topConstraint.constant = TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_SHOW_KEYBOARD;
                         }
                         self.bottomConstraint.constant = keyboardRelativeFrame.size.height - self.betweenButtonTableViewConstraint.constant - self.buttonHeightConstraint.constant - self.tabBarController.tabBar.bounds.size.height;
                         [self.view layoutIfNeeded];
                     }];
}

- (void)keyboardHide:(NSNotification *)nofification{
    
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.bottomConstraint.constant = BOTTOM_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_HIDE_KEYBOARD;
                         self.topConstraint.constant = TOP_CONSTRAINT_FOR_LANDSCAPE_ORIENTATIONS_HIDE_KEYBOARD;
                         [self.view layoutIfNeeded];
                     }];
}

#pragma mark - Actions

- (IBAction)pressSubmit {
    
    [self.spinner startAnimating];
    
    [self addToQuotePriceAndUser];
    
    //Create new quote item
    Quote *quote = [[Quote alloc] init];
    
    quote.meta = [[KCSMetadata alloc] init];
    quote.referenceNumber = self.quote.referenceNumber;
    quote.originator = self.quote.originator;
    quote.originator = self.quote.originator;
    quote.activeUsers = self.quote.activeUsers;
    quote.businessLogicScripts = self.quote.businessLogicScripts;
    quote.scheduledBusinessLogic = self.quote.scheduledBusinessLogic;
    quote.collaborators = self.quote.collaborators;
    quote.backendEnvironments = self.quote.backendEnvironments;
    quote.dataStorage = self.quote.dataStorage;
    quote.businessLogicExecutionTimeLimit = self.quote.businessLogicExecutionTimeLimit;
    quote.startSubscriptionDate = self.quote.startSubscriptionDate;
    quote.totalPrice = self.quote.totalPrice;
    quote.product = self.quote.product;
    
    //Save item to Quote collection
    [[DataHelper instance] saveQuote:quote
                           OnSuccess:^(NSArray *quotes){
                               if (quotes.count) {
                                   QuoteOrderModalViewController *mvc = [[QuoteOrderModalViewController alloc] init];
                                   if (self.quote) {
                                       mvc.item = quote;
                                       mvc.modalPresentationStyle = UIModalPresentationFormSheet;
                                       [self.tabBarController presentViewController:mvc
                                                                           animated:YES
                                                                         completion:^{
                                                                             mvc.item = quote;
                                                                         }];
                                   }
                               }
                               [self.spinner stopAnimating];
                           }
                           onFailure:^(NSError *error){
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(DV_MESSAGE_ERROR_CREATE_ORDER)
                                                                               message:error.localizedDescription
                                                                              delegate:nil
                                                                     cancelButtonTitle:LOC(OKAY)
                                                                     otherButtonTitles:nil];
                               [alert show];
                               [self.spinner stopAnimating];
                           }
     ];
}

- (void)addToQuotePriceAndUser{
    
    float fabPrice = random();
    fabPrice = (float)(random() % 74) / (float)(random() % 74);
    self.quote.totalPrice = [@"$" stringByAppendingFormat:@"1,500/month"];
    self.quote.referenceNumber = [@"Q" stringByAppendingFormat:@"%ld", (random() % 10000000)];
    self.quote.originator = [KCSUser activeUser];
}

- (IBAction)pressSettings {
    
    SettingModalViewController *mv = [[SettingModalViewController alloc] init];
    mv.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:mv
                       animated:YES
                     completion:nil];
}


#pragma mark - Utils

- (void)updateQuoteWithTextField:(UITextField *)textField andIndex:(NSInteger)index{
    
    NSString *placeholder = textField.placeholder;
    
    if ([placeholder isEqualToString:PLACEHOLDER_PRODUCT_TEXT_FIELD]) {
        self.quote.product = (Product *)self.products[index];
    }else if ([placeholder isEqualToString:PLACEHOLDER_ACTIVE_USER_TEXT_FIELD]) {
        self.quote.activeUsers = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_BUSINESS_LOGIC_SCRIPTS_TEXT_FIELD]){
        self.quote.businessLogicScripts = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_SCHEDULED_BUSINESS_LOGIC_TEXT_FIELD]){
        self.quote.scheduledBusinessLogic = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_COLLABORATORS_TEXT_FIELD]){
        self.quote.collaborators = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_BACKEND_ENVIROMENTS_TEXT_FIELD]){
        self.quote.backendEnvironments = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_DATA_STOREGE_TEXT_FIELD]){
        self.quote.dataStorage = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_BUSINESS_LOGIC_EXECUTION_TIME_LIMIT_TEXT_FIELD]){
        self.quote.businessLogicExecutionTimeLimit = textField.text;
    }else if ([placeholder isEqualToString:PLACEHOLDER_START_SUBSCRIPTION_DATE_TEXT_FIELD]){
        self.quote.startSubscriptionDate = [[DataHelper instance].formatter dateFromString:textField.text];
    }
}


#pragma mark - TEXT FIELD
#pragma mark - Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
        [self setNextResponderCellAfterCellWithTextFieldPlaceholder:textField.placeholder];
        
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.activeTextField = textField;
    
    if (self.pickerIndexPath) {
        NSIndexPath *indexPath = self.pickerIndexPath;
        self.pickerIndexPath = nil;
        [self deletePikerFromTableViewInIndexPath:indexPath];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self updateQuoteWithTextField:textField andIndex:0];
}

#pragma mark - Utils

- (void)setNextResponderCellAfterCellWithTextFieldPlaceholder:(NSString *)placeholder{
    
    BOOL isEditableCell = YES;
    NSIndexPath *indexPath;
    
    if ([placeholder isEqualToString:PLACEHOLDER_PRODUCT_TEXT_FIELD]) {
        indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_ACTIVE_USER_TEXT_FIELD]) {
        indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_BUSINESS_LOGIC_SCRIPTS_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_SCHEDULED_BUSINESS_LOGIC_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_COLLABORATORS_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_BACKEND_ENVIROMENTS_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_DATA_STOREGE_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
    }else if ([placeholder isEqualToString:PLACEHOLDER_BUSINESS_LOGIC_EXECUTION_TIME_LIMIT_TEXT_FIELD]){
        indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        isEditableCell = NO;
        [self addPickerViewForIndexPath:indexPath];
        indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    }
    
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    
    if (isEditableCell) {
        ComboBoxNewQuoteTableViewCell *cell = (ComboBoxNewQuoteTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
    }
}

#pragma mark - PICKER VIEW
#pragma mark - Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerItem[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    ComboBoxNewQuoteTableViewCell *cell = (ComboBoxNewQuoteTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.pickerIndexPath.row - 1 inSection:0]];
    
    cell.textField.text = self.pickerItem[row];
    NSIndexPath *indexPath = self.pickerIndexPath;
    self.pickerIndexPath = nil;
    [self deletePikerFromTableViewInIndexPath:indexPath];
    [self updateQuoteWithTextField:cell.textField andIndex:row];
    [self setNextResponderCellAfterCellWithTextFieldPlaceholder:cell.textField.placeholder];
}

#pragma mark - Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerItem.count;
}

#pragma mark - Utils

- (void)addPickerViewForIndexPath:(NSIndexPath *)indexPath{
    
    if ((self.pickerIndexPath) && (self.pickerIndexPath.row - 1 == indexPath.row)) {
        
        NSIndexPath *pickerIndexPath = self.pickerIndexPath;
        self.pickerIndexPath = nil;
        [self deletePikerFromTableViewInIndexPath:pickerIndexPath];
    }else if (self.pickerIndexPath){
        
        NSIndexPath *pickerIndexPath = self.pickerIndexPath;
        [self deletePikerFromTableViewInIndexPath:pickerIndexPath];
        NSInteger indexPahOffset;
        
        if (pickerIndexPath.row > indexPath.row){
            indexPahOffset = 1;
        }else{
            indexPahOffset = 0;
        }
        
        self.pickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + indexPahOffset inSection:0];
        [self insertPickerOnTableView];
    }else{
        
        self.pickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [self insertPickerOnTableView];
    }
    
}

- (NSArray *)pickerData{
    
    NSArray *result;
    
    switch (self.pickerIndexPath.row - 1) {
        case ProductCellIndex:{
            NSMutableArray *mResult = [NSMutableArray array];
            for (int i = 0; i < self.products.count; i++) {
                [mResult addObject:((Product *)self.products[i]).title];
            }
            result = [mResult copy];
        }break;
        default:
            break;
    }
    
    return result;
}

- (UIPickerView *)pickerViewForTableView{
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewWidthConstraint.constant, PICKER_VIEW_HEIGHT)];
    
    self.pickerItem = [self pickerData];
    
    [pickerView selectRow:0
              inComponent:0
                 animated:YES];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = self.tableView.backgroundColor;
    
    return pickerView;
}

- (void)selectedDate{
    
    ComboBoxNewQuoteTableViewCell *cell = (ComboBoxNewQuoteTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textField.text = [[DataHelper instance].formatter stringFromDate:[self.datePicker date]];
    [self updateQuoteWithTextField:cell.textField andIndex:0];
}

- (UIDatePicker *)datePickerForTableView{
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.tableViewWidthConstraint.constant, PICKER_VIEW_HEIGHT)];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]
               animated:YES];
    
    self.datePicker = datePicker;
    self.datePicker.backgroundColor = self.tableView.backgroundColor;
    
    [datePicker addTarget:nil
                   action:@selector(selectedDate)
         forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

#pragma mark - Table View
#pragma mark - Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.pickerIndexPath) {
        if (indexPath.row == self.pickerIndexPath.row) {
            
            return PICKER_VIEW_HEIGHT;
            
        }else{
            
            return COMBOBOX_NEW_QUOTE_CELL_HEGHT;
            
        }
    }else{
        
        return COMBOBOX_NEW_QUOTE_CELL_HEGHT;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.pickerIndexPath) {
        if (indexPath.row == self.pickerIndexPath.row) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            if (indexPath.row == 9) {
                [cell addSubview:[self datePickerForTableView]];
            }else{
                [cell addSubview:[self pickerViewForTableView]];
            }
            
            return cell;
            
        }else{
            ComboBoxNewQuoteTableViewCell *cell = [[ComboBoxNewQuoteTableViewCell alloc] init];
            cell.index = (indexPath.row > self.pickerIndexPath.row) ? indexPath.row - 1 : indexPath.row;
            cell.textField.delegate = self;
            NSString *currentValue = [self valueForCellAtIndex:indexPath.row];
            if (currentValue.length) {
                cell.textField.text = currentValue;
            }
            
            return cell;
            
        }
    }else{
        ComboBoxNewQuoteTableViewCell *cell = [[ComboBoxNewQuoteTableViewCell alloc] init];
        cell.index = indexPath.row;
        cell.textField.delegate = self;
        NSString *currentValue = [self valueForCellAtIndex:indexPath.row];
        if (currentValue.length) {
            cell.textField.text = currentValue;
        }
        
        return cell;
        
    }
 
}

- (NSString *)valueForCellAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
            if (self.quote.product) {
                
                return self.quote.product.title;
                
            }
            break;
        case 1:
            if (self.quote.activeUsers.length) {
                
                return self.quote.activeUsers;
                
            }
            break;
        case 2:
            if (self.quote.businessLogicScripts.length) {
                
                return self.quote.businessLogicScripts;
                
            }
            break;
        case 3:
            if (self.quote.scheduledBusinessLogic.length) {
                
                return self.quote.scheduledBusinessLogic;
                
            }
            break;
        case 4:
            if (self.quote.collaborators.length) {
                
                return self.quote.collaborators;
                
            }
            break;
        case 5:
            if (self.quote.backendEnvironments.length) {
                
                return self.quote.backendEnvironments;
                
            }
            break;
        case 6:
            if (self.quote.dataStorage.length) {
                
                return self.quote.dataStorage;
                
            }
            break;
        case 7:
            if (self.quote.businessLogicExecutionTimeLimit.length) {
                
                return self.quote.businessLogicExecutionTimeLimit;
                
            }
            break;
        case 8:
            if (self.quote.startSubscriptionDate) {
                
                return [[DataHelper instance].formatter stringFromDate:self.quote.startSubscriptionDate];
                
            }
            break;
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.activeTextField resignFirstResponder];
    if ((indexPath.row == 0) || (indexPath.row == 8)) {
        [self addPickerViewForIndexPath:indexPath];
    }else{
        [tableView beginUpdates];
        
        [tableView deselectRowAtIndexPath:indexPath
                                 animated:NO];
        
        [tableView endUpdates];
    }
}

#pragma mark - Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.countTableViewRows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - Utils

- (void)deletePikerFromTableViewInIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView beginUpdates];
    self.countTableViewRows --;
    
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0]
                                  animated:NO];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

- (void)insertPickerOnTableView{
    
    [self.tableView beginUpdates];
    self.countTableViewRows ++;
    
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:self.pickerIndexPath.row - 1 inSection:0]
                                  animated:NO];
    
    [self.tableView insertRowsAtIndexPaths:@[self.pickerIndexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

@end
