//
//  iTunesResultHandler.m
//  smule-2d-tableview
//
//  Created by nook on 7/18/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "iTunesResultHandler.h"

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

- (void) searchForAlbumArtwork{
    [self.iTunes queryFeedType:QueryTopAlbums forCountry:self.countryCode size:15 genre:0 asynchronizationMode:NO];
}

-(void) queryResult:(ITunesFeedsApiQueryStatus)status type:(ITunesFeedsQueryType)type results:(NSArray*)results
{
    [self.delegate resultsFetchedForCountry:self.countryCode withResults:results];
}

+ (void) getAlbumsForCountry: (NSString *) country withDelegate: (id) delegate{
    
    iTunesResultHandler * resultHandler = [[iTunesResultHandler alloc] initWithCountry:country];
    resultHandler.delegate = delegate;
    [resultHandler searchForAlbumArtwork];
}

@end
