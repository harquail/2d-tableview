//
//  iTunesResultHandler.h
//  smule-2d-tableview
//
//  Created by nook on 7/18/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iTunesApi/ITunesApi.h>
@protocol iTunesResultHandlerDelegate

- (void) resultsFetchedForCountry: (NSString *) country withResults: (NSArray *) results;

@end

@interface iTunesResultHandler : NSObject <ITunesFeedsApiDelegate>

@property NSString * countryCode;
@property (weak, nonatomic) id<iTunesResultHandlerDelegate> delegate;
@property ITunesFeedsApi * iTunes;

+ (void) getAlbumsForCountry: (NSString *) country withDelegate: (id) delegate;

@end
