//
//  twoDTableView.h
//  smule-2d-tableview
//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface twoDTableView : UITableView <UITableViewDataSource, UICollectionViewDataSource>

@end

@protocol twoDTableViewDataSource

- (NSInteger) rowsInTwoDTableView: (twoDTableView *) tableView;
- (NSInteger) colsInTwoDTableView: (twoDTableView *) tableView;


@end

