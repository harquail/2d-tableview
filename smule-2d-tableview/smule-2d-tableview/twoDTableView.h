//

//  twoDTableView.h
//  smule-2d-tableview//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol twoDTableViewDataSource <NSObject>

- (NSInteger) rowsInTwoDTableView: (UITableView *) tableView;
- (NSInteger) colsInTwoDTableView: (UITableView *) tableView inRow: (NSInteger) row;
- (UICollectionViewCell *) cellInTwoDTableView: (UITableView *) tableView collectionView: (UICollectionView *) collectionView atRow: (NSInteger) row atCol: (NSInteger) col;
- (NSString *) sectionTitleInTwoDTableView: (UITableView *) tableView atRow: (NSInteger) row;

@end

@protocol twoDTableViewDelegate <NSObject>

@optional - (void) tappedCellAtRow: (NSInteger) row atCol: (NSInteger) col;
@optional - (void) loadedRow: (NSInteger) row;

@end


@interface twoDTableView : UITableView <UITableViewDataSource, UICollectionViewDataSource>

@property id<twoDTableViewDataSource> twoDDataSource;
@property id<twoDTableViewDelegate> twoDDelegate;

@end

