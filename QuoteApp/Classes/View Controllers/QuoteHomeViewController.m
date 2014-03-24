//
//  QuoteHomeViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 27.2.14.
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

#import "QuoteHomeViewController.h"
#import "MainTableHeaderView.h"
#import "MainTableHeaderViewForIPhone.h"
#import "MainTableViewCell.h"
#import "MainTableViewCellForIPhone.h"
#import "QuoteOrderModalViewController.h"

#define HEIGHT_FOR_ROW 44
#define HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPHONE 60
#define HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPAD 95

@implementation QuoteHomeViewController


#pragma mark - Initialisation

- (NSString *)titleForView{
    return LOC(QHVC_TITLE);
}

- (NSString *)titleForRefreshControl{
    return LOC(QHVC_REFRESH_CONTROL_TITLE);
}


#pragma mark - Utils

- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    self.spinnerCount++;
    
    //Load all data form Quote collection
    [[DataHelper instance] loadQuotesUseCache:useCache      
                            containtSubstinrg:nil
                                    OnSuccess:^(NSArray *quotes) {
                                        self.items = quotes;
                                        self.spinnerCount--;
                                    }
                                    onFailure:^(NSError *error){
                                        self.spinnerCount --;
                                    }];
}


#pragma mark - TABLE VIEW
#pragma mark - Delegate

- (UIView *)headerForTableView{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        MainTableHeaderViewForIPhone *header = [[MainTableHeaderViewForIPhone alloc] initWithFrame:CGRectZero];
        header.type = HeaderViewMainTableTypeQuotes;
        
        return header;
        
    }else{
        MainTableHeaderView *header = [[MainTableHeaderView alloc] initWithFrame:CGRectZero];
        header.type = HeaderViewMainTableTypeQuotes;
        
        return header;
        
    }
}

- (void)detailViewForIndex:(NSInteger)index{
    
    QuoteOrderModalViewController *mvc = [[QuoteOrderModalViewController alloc] init];
    
    if (self.items.count) {
        mvc.modalPresentationStyle = UIModalPresentationFormSheet;
        mvc.item = self.items[index];
        [self.tabBarController presentViewController:mvc
                                            animated:YES
                                          completion:nil];
    }
}

- (CGFloat)heightForRow{
    return HEIGHT_FOR_ROW;
}

- (CGFloat)heightForHeaderInSection{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPHONE;
        
    }else{
        
        return HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPAD;
        
    }
}


#pragma mark - Data Source

- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        MainTableViewCellForIPhone * cell = [[MainTableViewCellForIPhone alloc] init];
        cell.item = self.items[indexPath.row];
        
        return cell;
        
    }else{
        MainTableViewCell *cell = [[MainTableViewCell alloc] init];
        cell.item = self.items[indexPath.row];
        
        return cell;
        
    }
}

- (NSString *)messageForEmptyItems{
    return LOC(QHVC_CELL_NO_QUOTE);
}

#pragma mark - Search Bar Delegate

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    //Load data which containts search string from Quote collection
    [[DataHelper instance] loadQuotesUseCache:YES
                           containtSubstinrg:searchString
                                   OnSuccess:^(NSArray *quotes) {
                                                self.isSearchProcess = NO;
                                                self.items = quotes;
                                                self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                                if (self.isNeedRemoveSearchView) {
                                                    [super hideSearchBar];
                                                }
                                            }
                                   onFailure:nil];
}

@end
