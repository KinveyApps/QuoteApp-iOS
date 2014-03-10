//
//  HomeViewController.m
//  QuoteApp
//
//  Created by Igor Sapyanik on 5.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingsDetailView.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isNeedSearh;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) UIRefreshControl *tableViewRefreshControl;
@property (nonatomic, strong) UIRefreshControl *collectionViewRefreshControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) SettingsDetailView *settingsView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;


@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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


- (void)setup{
    [[NSBundle mainBundle] loadNibNamed:@"HomeViewController" owner:self options:nil];
    [self.tableViewRefreshControl addTarget:self
                                     action:@selector(updateData)
                           forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.tableViewRefreshControl];
    [self.collectionViewRefreshControl addTarget:self
                                          action:@selector(updateData)
                                forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.collectionViewRefreshControl];
}

- (void)updateData{
    [self getDataForItemsFromCache:NO];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.searchBar.delegate = self;
    
    self.tableGridSegmentedControl.hidden = [self isVisibleTableGridSegmentedControl];
    [self.collectionView registerClass:[self classForCollectionViewCell] forCellWithReuseIdentifier:[self reusebleCollectionViewID]];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGFloat cellWidth = (320 - 2 * (2 + 1)) / 2;
        self.collectionViewFlowLayout.itemSize = CGSizeMake(cellWidth, cellWidth / 4 * 3);
        self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        self.collectionViewFlowLayout.minimumInteritemSpacing = 2;
        self.collectionViewFlowLayout.minimumLineSpacing = 2;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.collectionView addSubview:self.tableViewRefreshControl];
}


- (void)viewDidLayoutSubviews{
    if (self.settingsView) {
        self.settingsView.frame = self.tabBarController.view.bounds;
    }
}

- (Class)classForCollectionViewCell{
    return [UICollectionViewCell class];//abstract
}

- (NSString *)reusebleCollectionViewID{
    return @"Default ID";
}

- (BOOL)isVisibleTableGridSegmentedControl{
    return YES;//abstract
}

- (NSString *)titleForRefreshControl{
    return nil;//abstract
}

- (void)setSpinnerCount:(NSUInteger *)spinnerCount{
    _spinnerCount = spinnerCount;
    if (_spinnerCount > 0) {
        //[self.spinner startAnimating];
        if (self.collectionView.hidden) {
            if (!self.tableViewRefreshControl.isRefreshing) {
                [self.tableViewRefreshControl beginRefreshing];
            }
        }else{
            if (!self.collectionViewRefreshControl.isRefreshing) {
                [self.collectionViewRefreshControl beginRefreshing];
            }
        }
    }else{
        _spinnerCount = 0;
        //[self.spinner stopAnimating];
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

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self laodData];
}


- (void)laodData{
    
    [self getDataForItemsFromCache:YES];
    
}

- (void)getDataForItemsFromCache:(BOOL)useCache{
    //abstract
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pressSearch {
    [UIView animateWithDuration:0.3 animations:^{
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
    self.searchBarTopConstraint.constant = -44;
    [self getDataForItemsFromCache:YES];
    self.searchCountResultLabel.hidden = YES;
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];

    }
}


- (IBAction)pressSettings {
    self.settingsView = [[SettingsDetailView alloc] initWithFrame:self.tabBarController.view.bounds];
    [self.tabBarController.view addSubview:self.settingsView];
    
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

#pragma mark - Table View Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerForTableView];
}

- (UIView *)headerForTableView{
    return nil;//abstract
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self detailViewForIndex:indexPath.row];
}

- (void)detailViewForIndex:(NSInteger)index{
    //abstract
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForRow];
}

- (CGFloat)heightForRow{
    return 0; //abstract
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self heightForHeaderInSection];
}

- (CGFloat)heightForHeaderInSection{
    return 0; //abstract
}

#pragma mark - Table View Data Source

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

- (NSString *)messageForEmptyItems{
    return nil;//abstract
}

- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    return nil;//abstract
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.items.count) {
        return self.items.count;
    }else{
        return 1;
    }
}

#pragma mark - Search Bar Delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(searchIfNeed) userInfo:nil repeats:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isNeedSearh = YES;
    if (!self.isSearchProcess) {
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(searchIfNeed) userInfo:nil repeats:YES];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.isNeedRemoveSearchView = YES;

    if (!self.isSearchProcess) {
        [self sendSearchRequestWithString:self.searchBar.text];
    }
    
}

- (void)startSearchWithSubstring{
    
    self.spinnerCount ++;
    self.isSearchProcess = YES;
    self.searchText = self.searchBar.text;
    [self sendSearchRequestWithString:self.searchBar.text];
}

- (void)sendSearchRequestWithString:(NSString *)searchString{
    //abstract
}

- (void)searchIfNeed{
    if (self.isNeedSearh) {
        [self startSearchWithSubstring];
        self.isNeedSearh = NO;
    }
}

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

- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath{
    //abstract
}

#pragma mark - Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self detailViewForIndex:indexPath.row];
}

@end
