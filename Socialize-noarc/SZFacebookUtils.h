//
//  SZFacebookUtils.h
//  SocializeSDK
//
//  Created by Nathaniel Griswold on 5/9/12.
//  Copyright (c) 2012 Socialize, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocializeObjects.h"
#import "SZDisplay.h"
#import "SZFacebookLinkOptions.h"

@interface SZFacebookUtils : NSObject

+ (void)setAppId:(NSString*)appId expirationDate:(NSDate*)expirationDate;
+ (NSString*)accessToken;
+ (NSDate*)expirationDate;
+ (void)setURLSchemeSuffix:(NSString*)suffix;
+ (BOOL)isAvailable;
+ (BOOL)isLinked;

+ (void)linkWithAccessToken:(NSString*)accessToken expirationDate:(NSDate*)expirationDate success:(void(^)(id<SZFullUser>))success failure:(void(^)(NSError *error))failure;
+ (void)linkWithViewController:(UIViewController*)viewController options:(SZFacebookLinkOptions*)options success:(void(^)(id<SZFullUser>))success failure:(void(^)(NSError *error))failure;
+ (void)unlink;

+ (void)postWithGraphPath:(NSString*)graphPath params:(NSDictionary*)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure;
+ (void)getWithGraphPath:(NSString*)graphPath params:(NSDictionary*)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure;
+ (void)deleteWithGraphPath:(NSString*)graphPath params:(NSDictionary*)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure;

@end
