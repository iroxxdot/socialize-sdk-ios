//
//  SocializeThirdPartyFacebook.m
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 3/1/12.
//  Copyright (c) 2012 Socialize, Inc. All rights reserved.
//

#import "SocializeThirdPartyFacebook.h"
#import "SocializeCommonDefinitions.h"
#import "_Socialize.h"

@implementation SocializeThirdPartyFacebook

+ (NSString *)baseUrlForAppId:(NSString*)appId localAppId:(NSString*)localAppId {
    return [NSString stringWithFormat:@"fb%@%@://authorize",
            appId,
            localAppId ? localAppId : @""];
}

+ (NSString*)facebookAppId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kSocializeFacebookAuthAppId];
}

+ (NSString*)facebookLocalAppId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kSocializeFacebookAuthLocalAppId];
}

+ (void)storeLocalCredentialsWithAccessToken:(NSString*)accessToken
                              expirationDate:(NSDate*)expirationDate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expirationDate forKey:@"FBExpirationDateKey"];

    [defaults synchronize];
}

+ (NSString*)facebookUrlSchemeSuffix {
    return [self facebookLocalAppId];
}

+ (NSString*)facebookAccessToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSocializeFacebookAuthAccessToken];
}

+ (NSString*)facebookExpirationDate {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSocializeFacebookAuthExpirationDate];
}

+ (NSString*)socializeAuthToken {
    return [self facebookAccessToken];
}

+ (NSString*)socializeAuthTokenSecret {
    return nil;
}

+ (SocializeThirdPartyAuthType)socializeAuthType {
    return SocializeThirdPartyAuthTypeFacebook;
}

+ (BOOL)authenticationPossible {
    NSString *facebookAppId = [self facebookAppId];
    NSString *facebookLocalAppId = [self facebookLocalAppId];
    if (facebookAppId == nil) {
        return NO;
    }
    
    NSURL *testURL = [NSURL URLWithString:[self baseUrlForAppId:facebookAppId localAppId:facebookLocalAppId]];
    if (![[UIApplication sharedApplication] canOpenURL:testURL]) {
        return NO;
    }
    
    return YES;
}

+ (NSError*)thirdPartyUnavailableError {
    return [NSError defaultSocializeErrorForCode:SocializeErrorFacebookUnavailable];
}

+ (NSError*)userAbortedAuthError {
    return [NSError defaultSocializeErrorForCode:SocializeErrorFacebookCancelledByUser];
}

+ (NSString*)thirdPartyName {
    return @"Facebook";
}

+ (BOOL)isAuthenticated {
    return [self hasLocalCredentials] && [[Socialize sharedSocialize] isAuthenticatedWithAuthType:kSocializeFacebookStringForAPI];
}

+ (BOOL)hasLocalCredentials {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kSocializeFacebookAuthAccessToken] != nil &&
    [[defaults objectForKey:kSocializeFacebookAuthExpirationDate] timeIntervalSinceNow] > 0;
}

+ (void)removeLocalCredentials {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kSocializeFacebookAuthAccessToken];
    [defaults removeObjectForKey:kSocializeFacebookAuthExpirationDate];
}

@end
