//
//  HomeViewController.m
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

#import "HomeViewController.h"
#import "SettingModalViewController.h"

#define COUNT_COLLECTION_VIEW_CELL_IN_ROW_FOR_IPHONE 2
#define ASPECT_RATIO_COLLECTION_VIEW_CELL 4 * 3
#define INSTANT_SEARCH_TIME_INTEVAL 1

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) UIRefreshControl *tableViewRefreshControl;
@property (nonatomic, strong) UIRefreshControl *collectionViewRefreshControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isNeedSearh;
@property (nonatomic, strong) NSString *searchText;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTopConstraint;

@end


@implementation HomeViewController


#pragma mark - Initialisation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    [[NSBundle mainBundle] loadNibNamed:@"HomeViewController" owner:self options:nil];
    
    [self.tableViewRefreshControl addTarget:self
                                     action:@selector(updateData)
                           forControlEvents:UIControlEventValueChanged];
    [self.tableViewRefreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:[self titleForRefreshControl]]];
    self.tableViewRefreshControl.layer.zPosition -= 1;
    [self.tableView addSubview:self.tableViewRefreshControl];
    
    [self.collectionViewRefreshControl addTarget:self
                                          action:@selector(updateData)
                                forControlEvents:UIControlEventValueChanged];
    [self.collectionViewRefreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:[self titleForRefreshControl]]];
    self.collectionViewRefreshControl.layer.zPosition -= 1;
    [self.collectionView addSubview:self.collectionViewRefreshControl];
    
    self.topBarView.backgroundColor = BAR_COLOR;
    self.titleLable.text = [self titleForView];
}

- (void)updateData{
    
    [self getDataForItemsFromCache:NO];
}

- (NSString *)titleForView{ return nil; }//abstract

- (NSString *)titleForRefreshControl{ return nil;}//abstract


#pragma mark - Setters and Getters

- (UIRefreshControl *)tableViewRefreshControl{
    
    if (!_tableViewRefreshControl) {
        _tableViewRefreshControl = [[UIRefreshControl alloc] init];
    }
    
    return _tableViewRefreshControl;
}

- (UIRefreshControl *)collectionViewRefreshControl{
    
    if (!_collectionViewRefreshControl) {
        _collectionViewRefreshControl = [[UIRefreshControl alloc] init];
    }
    
    return _collectionViewRefreshControl;
}

- (void)setSpinnerCount:(NSInteger)spinnerCount{
    
    _spinnerCount = spinnerCount;
    
    if (_spinnerCount > 0) {
        
        if (self.collectionView.hidden) {
            if (!self.tableViewRefreshControl.isRefreshing) {
                [self.tableViewRefreshControl beginRefreshing];
                self.tableViewRefreshControl.hidden = NO;
            }
        }else{
            if (!self.collectionViewRefreshControl.isRefreshing) {
                [self.collectionViewRefreshControl beginRefreshing];
                self.collectionViewRefreshControl.hidden = NO;
            }
        }
        
    }else{
        _spinnerCount = 0;
        
        if (self.collectionView.hidden) {
            [self.tableViewRefreshControl endRefreshing];
        }else{
            [self.collectionViewRefreshControl endRefreshing];
        }
        
    }
}

- (void)setItems:(NSArray *)items{
    
    _items = items;
    
    if (self.collectionView.hidden) {
        [self.tableView reloadData];
    }else{
        [self.collectionView reloadData];
    }
}


#pragma mark - View Life Cycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.searchBar.delegate = self;
    
    self.tableGridSegmentedControl.hidden = [self isVisibleTableGridSegmentedControl];
    
    [self.collectionView registerClass:[self classForCollectionViewCell]
            forCellWithReuseIdentifier:[self reusebleCollectionViewID]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGFloat cellWidth = (self.view.bounds.size.width - self.collectionViewFlowLayout.minimumInteritemSpacing * (COUNT_COLLECTION_VIEW_CELL_IN_ROW_FOR_IPHONE + 1)) / COUNT_COLLECTION_VIEW_CELL_IN_ROW_FOR_IPHONE;
        self.collectionViewFlowLayout.itemSize = CGSizeMake(cellWidth, cellWidth / ASPECT_RATIO_COLLECTION_VIEW_CELL);
        [self.collectionView layoutIfNeeded];
    }
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([AuthenticationHelper instance].isSignedIn) {
        [self laodData];
    }
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

- (void)laodData{
    
    [self getDataForItemsFromCache:YES];
}

- (BOOL)isVisibleTableGridSegmentedControl{ return YES; }//abstract

- (Class)classForCollectionViewCell{ return [UICollectionViewCell class]; }//abstract

- (NSString *)reusebleCollectionViewID{ return @"Default ID"; }//abstract


#pragma mark - Utils

- (void)getDataForItemsFromCache:(BOOL)useCache{ }//abstract


#pragma mark - Actions

- (IBAction)pressSearch {
    
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         
        if (self.searchBarTopConstraint.constant) {
            [self showSearchBar];
        }else{
            [self hideSearchBar];
        }
        [self.view layoutIfNeeded];
                         
    }];
}

- (void)showSearchBar{
    
    self.searchBarTopConstraint.constant = 0;
    self.searchCountResultLabel.hidden = NO;
    [self.searchBar becomeFirstResponder];
}

- (void)hideSearchBar{
    
    self.searchBarTopConstraint.constant = -self.searchBar.frame.size.height;
    [self getDataForItemsFromCache:YES];
    self.searchCountResultLabel.hidden = YES;
    
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

- (IBAction)pressSettings {
    
    SettingModalViewController *mv = [[SettingModalViewController alloc] init];
    mv.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:mv
                       animated:YES
                     completion:nil];
    
}

- (IBAction)changeTableGridView:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex) {
        self.collectionView.hidden = NO;
        self.tableView.hidden = YES;
        [self.collectionView reloadData];
    }else{
        self.collectionView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}


#pragma mark - TABLE VIEW
#pragma mark - Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerForTableView];
}

- (UIView *)headerForTableView{ return nil; }//abstract

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self detailViewForIndex:indexPath.row];
}

- (void)detailViewForIndex:(NSInteger)index{ }//abstract

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForRow];
}

- (CGFloat)heightForRow{ return 0; }//abstract

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self heightForHeaderInSection];
}

- (CGFloat)heightForHeaderInSection{ return 0; }//abstract


#pragma mark - Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.items.count) {
        
        return [self cellForTableViewAtIndexPath:indexPath];
        
    }else{
        UITableViewCell *cellForNoItem = [[UITableViewCell alloc] init];
        cellForNoItem.textLabel.text = [self messageForEmptyItems];
        
        return cellForNoItem;
    }
}

- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath{ return nil; }//abstract

- (NSString *)messageForEmptyItems{ return nil; }//abstract

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.items.count) {
        return self.items.count;
    }else{
        return 1;
    }
}


#pragma mark - Search Bar Delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self hideSearchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    if (self.isNeedSearh) {
        [self.timer fire];
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.isNeedSearh = YES;
    if (!self.isSearchProcess) {
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:INSTANT_SEARCH_TIME_INTEVAL
                                                      target:self
                                                    selector:@selector(searchIfNeed)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (!self.isSearchProcess) {
        [self sendSearchRequestWithString:self.searchBar.text];
    }
}

- (void)startSearchWithSubstring{
    
    self.isSearchProcess = YES;
    self.searchText = self.searchBar.text;
    [self sendSearchRequestWithString:self.searchBar.text];
}

- (void)searchIfNeed{
    
    if (self.isNeedSearh) {
        [self startSearchWithSubstring];
        self.isNeedSearh = NO;
    }
}

- (void)sendSearchRequestWithString:(NSString *)searchString{ }//abstract


#pragma mark - COLLECTION VIEW
#pragma mark - Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self reusebleCollectionViewID] forIndexPath:indexPath];
    
    [cell setClipsToBounds:YES];
    cell.layer.cornerRadius = 2.0f;
    [self updateCell:cell forCollectionViewAtIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath{ }//abstract


#pragma mark - Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self detailViewForIndex:indexPath.row];
}

@end
