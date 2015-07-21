//
//  iTunesResultHandler.h
//  smule-2d-tableview
//
//  Created by nook on 7/18/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iTunesApi/ITunesApi.h>

/**
 Delegate are notified when results are downloaded from iTunes API
 */
@protocol iTunesResultHandlerDelegate

/**
 notification method fires on completion of download
 @param country the two-character country code that was queried
 @param results an array of ITunesAlbums
 */
- (void) resultsFetchedForCountry: (NSString *) country withResults: (NSArray *) results;

@end

@interface iTunesResultHandler : NSObject <ITunesFeedsApiDelegate>

/**
 Two-character country code
*/
@property NSString * countryCode;
/**
 Delegate notified when results are fetched from iTunes
*/
@property (weak, nonatomic) id<iTunesResultHandlerDelegate> delegate;

/**
 An iTunesFeedsAPI object used to query iTunes
 */
@property ITunesFeedsApi * iTunes;

/**
 Fetches top albums for a country from the iTunes API, creating an iTunesResultHandler object internally
 @param country the country code to search for top albums
 @param delegate delegate notified about
 */
+ (void) getAlbumsForCountry: (NSString *) country withDelegate: (id) delegate;

@end
