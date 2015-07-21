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

#define kAlbumWidth 100

@interface topAlbumsViewController ()

// tableview that holds albums
@property (strong, nonatomic) IBOutlet twoDTableView *tableView;

// a list (array of dictionaries) of country names and country codes
@property NSArray * countryCodes;

// results of album search (dictionary of ITunesAlbums).  Keys are the country codes
@property NSMutableDictionary * albumSearchResults;

@end

@implementation topAlbumsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // load country data from plist
        _countryCodes = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"iTunesCountries" ofType:@"plist"]];
        _albumSearchResults = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make rows a little bigger than albums
    _tableView.rowHeight = kAlbumWidth + 10;
    _tableView.twoDDataSource = self;
    _tableView.twoDDelegate = self;
    
    // because the first 5 cells are visible at the same time, they get fetched at very similar times
    // this prevents a race condition between the cells calling reload row
    [_tableView performSelector:@selector(reloadData) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

#pragma mark - 2d table view data source methods

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

- (UICollectionViewCell *)cellInTwoDTableView:(twoDTableView *)tableView collectionView:(UICollectionView *)collectionView atRow:(NSInteger)row atCol:(NSInteger) col{
    
    //make a collectionviewcell with a placeholder image
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
               }
     ];

    return cell;
}

#pragma mark - private methods

// helper method to find index of country in _countryCodes
- (int) rowForCountry: (NSString *) country{
    for (int i =0; i<_countryCodes.count; i++){
        if ([country isEqualToString:_countryCodes[i][@"Code"]]){
            return i;
        }
    }
    return -1;
}

#pragma mark - 2d table view delegate methods

// fetch results for rows as they are displayed
- (void)loadedRow:(NSInteger)row{
    NSString * country =  _countryCodes[row][@"Code"];
    if(!_albumSearchResults[country]){
        [iTunesResultHandler getAlbumsForCountry:country withDelegate:self];
    }
}

- (void)tappedCellAtRow:(NSInteger)row atCol:(NSInteger)col{
    ITunesAlbum * album = _albumSearchResults[_countryCodes[row][@"Code"]][col];
    //create url for youtube search
    NSString * url = [[NSString stringWithFormat:@"http://m.youtube.com/results?q=%@ %@",album.collectionName,album.artistName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)resultsFetchedForCountry:(NSString *)country withResults:(NSArray *)results{
    
    _albumSearchResults[country] = results;
    
    // reload tableview row that has changed
    [_tableView beginUpdates];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:[self rowForCountry:country]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView endUpdates];
}

@end
