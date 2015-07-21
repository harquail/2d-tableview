//
//  iTunesResultHandler.m
//  smule-2d-tableview
//
//  Created by nook on 7/18/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "iTunesResultHandler.h"
#define kNumberOfAlbumsToFetch 10

@implementation iTunesResultHandler

- (instancetype)initWithCountry: (NSString *) country
{
    self = [super init];
    if (self) {
        self.countryCode = country;
        self.iTunes = [[ITunesFeedsApi alloc] init];
        [self.iTunes setDelegate:self];
    }
    return self;
}

#pragma mark - private method

- (void) searchForAlbumArtwork{
    [self.iTunes queryFeedType:QueryTopAlbums forCountry:self.countryCode size:kNumberOfAlbumsToFetch genre:0 asynchronizationMode:YES];
}

#pragma mark - ITunesFeedsApi delegate method

-(void) queryResult:(ITunesFeedsApiQueryStatus)status type:(ITunesFeedsQueryType)type results:(NSArray*)results
{
    [self.delegate resultsFetchedForCountry:self.countryCode withResults:results];
}

#pragma mark - public method

// fetches results from itunes API for a country; takes a delegate to notify when results return
+ (void) getAlbumsForCountry: (NSString *) country withDelegate: (id) delegate{
    
    iTunesResultHandler * resultHandler = [[iTunesResultHandler alloc] initWithCountry:country];
    resultHandler.delegate = delegate;
    [resultHandler searchForAlbumArtwork];
}

@end
