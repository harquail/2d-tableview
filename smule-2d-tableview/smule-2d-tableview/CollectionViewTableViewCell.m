//
//  CollectionViewTableViewCell.m
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "CollectionViewTableViewCell.h"

@implementation CollectionViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    NSLog(@"reached init with frame");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        layout.itemSize = CGSizeMake(1, 1);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 40) collectionViewLayout:layout];
        [self.collectionView setUserInteractionEnabled:YES];
    
        [self.contentView addSubview:self.collectionView];
        [self layoutSubviews];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseMeAlso"];
    }
    return self;


}


- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"reached init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView = [[UICollectionView alloc] init];
        [self.contentView addSubview:self.collectionView];
        [self layoutSubviews];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
