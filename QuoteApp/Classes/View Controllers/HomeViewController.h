//
//  HomeViewController.h
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

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (strong, nonatomic) NSArray *items;
@property (nonatomic) BOOL isSearchProcess;
@property (nonatomic) BOOL isNeedRemoveSearchView;

@property (weak, nonatomic) IBOutlet UILabel *searchCountResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableGridSegmentedControl;

@property (nonatomic) NSInteger spinnerCount;


- (void)laodData;
- (void)hideSearchBar;

//abstract messages
//Get data
- (void)getDataForItemsFromCache:(BOOL)useCache;
- (void)sendSearchRequestWithString:(NSString *)searchString;

//Table view
- (UIView *)headerForTableView;
- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRow;
- (CGFloat)heightForHeaderInSection;

//UI
- (void)detailViewForIndex:(NSInteger)index;
- (NSString *)titleForRefreshControl;

- (NSString *)messageForEmptyItems;
- (BOOL)isVisibleTableGridSegmentedControl;
- (NSString *)titleForView;

//Collection view
- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath;
- (Class)classForCollectionViewCell;
- (NSString *)reusebleCollectionViewID;

@end
