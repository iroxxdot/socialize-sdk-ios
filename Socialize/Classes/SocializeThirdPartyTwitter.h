//
//  SocializeThirdPartyTwitter.h
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 3/1/12.
//  Copyright (c) 2012 Socialize, Inc. All rights reserved.
//

#import "SocializeThirdParty.h"

@interface SocializeThirdPartyTwitter : NSObject <SocializeThirdParty>

+ (NSString*)accessToken;
+ (NSString*)accessTokenSecret;
+ (void)removeTwitterCookies;
+ (void)storeLocalCredentialsAccessToken:(NSString*)accessToken
                       accessTokenSecret:(NSString*)accessTokenSecret
                              screenName:(NSString*)screenName
                                  userId:(NSString*)userId;

@end
