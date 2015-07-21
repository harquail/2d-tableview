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
@property (nonatomic, weak) id <UICollectionViewDataSource> dataSource;

/**
 Initializer
 @param style style for cell
 @param reuseIdentifier identifier for reusing cached cells
 @param itemSize size of collectionview cells the cells contains
 */
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize: (CGSize) size;

@end
