//
//  OrderHomeViewController.m
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

#import "OrderHomeViewController.h"
#import "MainTableHeaderView.h"
#import "MainTableViewCell.h"
#import "MainTableHeaderViewForIPhone.h"
#import "MainTableViewCellForIPhone.h"
#import "QuoteOrderModalViewController.h"
#import "DejalActivityView.h"

#define HEIGHT_FOR_ROW 44
#define HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPHONE 44
#define HEIGHT_FOR_HEADER_IN_SECTION_FOR_IPAD 60

@implementation OrderHomeViewController


#pragma mark - Initialisation

- (NSString *)titleForView{
    return LOC(OHVC_TITLE);
}


- (NSString *)titleForRefreshControl{
    return LOC(OHVC_REFRESH_CONTROL_TITLE);
}


#pragma mark - Utils

- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    if (!useCache) self.spinnerCount++;
    
    //Load all data from Order collection
    [[DataHelper instance] loadOrdersUseCache:useCache
                            containtSubstinrg:nil
                                    OnSuccess:^(NSArray *orders) {
                                        
                                        self.items = orders;
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
        header.type = HeaderViewMainTableTypeOrder;
        
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

- (void)deleteItemAtIndex:(NSUInteger)index{
    
    Order *orderForDelete;
    if (index < self.items.count)
        orderForDelete = self.items[index];
    
    if (orderForDelete) {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Deleting..."];
        
        [[DataHelper instance] deleteOrder:orderForDelete
                                 onSuccess:^(BOOL result) {
                                     
                                     [self sendSearchRequestWithString:nil];
                                     
                                 } onFailure:^(NSError *error) {
                                     
                                     [self sendSearchRequestWithString:nil];
                                     [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:error.localizedDescription
                                                                delegate:nil
                                                       cancelButtonTitle:LOC(OKAY)
                                                       otherButtonTitles:nil] show];
                                 }];
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
    return LOC(OHVC_CELL_NO_ORDER);
}

#pragma mark - Search Bar Delegate

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    //Load data which containts search string from Order collection
    [[DataHelper instance] loadOrdersUseCache:NO
                           containtSubstinrg:searchString
                                   OnSuccess:^(NSArray *orders) {
                                       
                                                [DejalActivityView removeView];
                                                self.isSearchProcess = NO;
                                                self.items = orders;
                                                self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                            }
                                   onFailure:nil];
}

@end
