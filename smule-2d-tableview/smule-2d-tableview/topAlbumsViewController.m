//
//  topAlbumsViewController.m
//  smule-2d-tableview
//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "topAlbumsViewController.h"
#import "iTunesResultHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface topAlbumsViewController ()
@property (strong, nonatomic) IBOutlet twoDTableView *tableView;
@property NSArray * countryCodes;
@property NSMutableDictionary * albumSearchResults;

@end

@implementation topAlbumsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _countryCodes = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"iTunesCountries" ofType:@"plist"]];
        _albumSearchResults = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.rowHeight = 110;
    _tableView.twoDDataSource = self;
    _tableView.twoDDelegate = self;
}

- (void)loadedRow:(NSInteger)row{
    NSString * country =  _countryCodes[row][@"Code"];
    if(!_albumSearchResults[country]){
        [iTunesResultHandler getAlbumsForCountry:country withDelegate:self];
    }
}

- (void) fetchCountry: (NSNumber *) atIndex{
    NSString * country =  _countryCodes[atIndex.integerValue][@"Code"];
    [iTunesResultHandler getAlbumsForCountry:country withDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [_albumSearchResults removeAllObjects];
    [[SDImageCache sharedImageCache] clearMemory];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewCell *)cellInTwoDTableView:(twoDTableView *)tableView collectionView:(UICollectionView *)collectionView atRow:(NSInteger)row atCol:(NSInteger) col{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMe" forIndexPath:[NSIndexPath indexPathForRow: col inSection:0]];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell addSubview:imageView];
    
    
    
    NSArray * resultsForCountry = _albumSearchResults[_countryCodes[row][@"Code"]];
    NSString * url;
    
    // set url to album artwork if it exists
    if(resultsForCountry.count > col){
        ITunesAlbum * album = resultsForCountry[col];
        url = album.artworkUrl100;
    }
    
    // get a placeholder image if the url is nil
    url = url ?: @"https://placeholdit.imgix.net/~text?txtsize=20&txt=90x90&w=90&h=90";
    
    // load images asynchronously
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [imageView setNeedsLayout];
                            [cell setNeedsLayout];
                        }];
    
    return cell;
    
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (NSInteger)rowsInTwoDTableView:(UITableView *)tableView{
    return _countryCodes.count;
}


- (NSInteger)colsInTwoDTableView:(UITableView *)tableView inRow: (NSInteger) row{
    NSArray * results = _albumSearchResults[_countryCodes[0][@"Code"]];
    return results.count;
}

- (NSString *)sectionTitleInTwoDTableView:(twoDTableView *)tableView atRow:(NSInteger)row{
    return _countryCodes[row][@"Country"];
}

- (int) rowForCountry: (NSString *) country{
    
    for (int i =0; i<_countryCodes.count; i++){
        if ([country isEqualToString:_countryCodes[i][@"Code"]]){
            return i;
        }
    }
    return -1;
}

- (void)resultsFetchedForCountry:(NSString *)country withResults:(NSArray *)results{
    
    _albumSearchResults[country] = results;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:[self rowForCountry:country]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tappedCellAtRow:(NSInteger)row atCol:(NSInteger)col{
    ITunesAlbum * album = _albumSearchResults[_countryCodes[row][@"Code"]][col];
    
    //create url for youtube search
    NSString * url = [[NSString stringWithFormat:@"http://m.youtube.com/results?q=%@ %@",album.collectionName,album.artistName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


@end
