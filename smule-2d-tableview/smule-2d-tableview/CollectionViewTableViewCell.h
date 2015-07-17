//
//  CollectionViewTableViewCell.h
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewTableViewCell : UITableViewCell
@property UICollectionView * collectionView;

@property int rower;
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;

@end
