//
//  QuoteHomeViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 27.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "QuoteHomeViewController.h"
#import "MainTableHeaderView.h"
#import "MainTableHeaderViewForIPhone.h"
#import "MainTableViewCell.h"
#import "MainTableViewCellForIPhone.h"
#import "QuoteOrderModalViewController.h"


@interface QuoteHomeViewController ()

@end

@implementation QuoteHomeViewController

- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    self.spinnerCount++;
    
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

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    [[DataHelper instance] loadQuotesUseCache:YES
                           containtSubstinrg:searchString
                                   OnSuccess:^(NSArray *quotes) {
                                                self.isSearchProcess = NO;
                                                self.items = quotes;
                                                self.spinnerCount --;
                                                self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                                if (self.isNeedRemoveSearchView) {
                                                    [super hideSearchBar];
                                                }
                                            }
                                   onFailure:^(NSError *error){
                                                self.spinnerCount --;
                                            }];
}

- (CGFloat)heightForRow{
    return 44;
}

- (CGFloat)heightForHeaderInSection{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 60;
    }else{
        return 95;
    }
}

- (void)detailViewForIndex:(NSInteger)index{
    QuoteOrderModalViewController *mvc = [[QuoteOrderModalViewController alloc] init];
    if (self.items.count) {
        mvc.modalPresentationStyle = UIModalPresentationFormSheet;
        mvc.item = self.items[index];
        [self.tabBarController presentViewController:mvc
                                            animated:YES
                                          completion:^{
                                          }];
    }
}

- (NSString *)messageForEmptyItems{
    return LOC(QHVC_CELL_NO_QUOTE);
}

- (NSString *)titleForRefreshControl{
    return LOC(QHVC_REFRESH_CONTROL_TITLE);
}

- (NSString *)titleForView{
    return LOC(QHVC_TITLE);
}

@end
