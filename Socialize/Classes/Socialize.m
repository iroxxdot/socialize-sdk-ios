//
//  SocializeService.m
//  SocializeSDK
//
//  Created by William Johnson on 5/31/11.
//  Copyright 2011 Socialize, Inc. All rights reserved.
//

#import "Socialize.h"
#import "SocializeCommentsService.h"
#import "SocializeConfiguration.h"

#define SOCIALIZE_API_KEY @"socialize_api_key"
#define SOCIALIZE_API_SECRET @"socialize_api_secret"
#define SOCIALIZE_FACEBOOK_APP_ID @"socialize_facebook_app_id"

@implementation Socialize

@synthesize authService = _authService;
@synthesize likeService = _likeService;
@synthesize commentsService = _commentsService;
@synthesize entityService = _entityService;
@synthesize viewService = _viewService;

- (void)dealloc {
    [_objectFactory release]; _objectFactory = nil;
    [_authService release]; _authService = nil;
    [_likeService release]; _likeService = nil;
    [_commentsService release]; _commentsService = nil;
    [_entityService release]; _entityService = nil;
    [_viewService release]; _viewService = nil;
    
    [super dealloc];
}

-(id) initWithDelegate:(id<SocializeServiceDelegate>)delegate
{
    self = [super init];
    if(self != nil)
    {
        _objectFactory = [[SocializeObjectFactory alloc]init];
        SocializeConfiguration* configurationLoader = [[SocializeConfiguration alloc]init];
        NSDictionary* configuration = [configurationLoader.configurationInfo objectForKey:@"URLs"];
        SocializeProvider* _provider = [[SocializeProvider alloc] initWithServerURL:[configuration objectForKey:@"RestserverBaseURL"]andSecureServerURL:[configuration objectForKey:@"SecureRestserverBaseURL"]];
        
        [configurationLoader release];
        
        _authService = [[SocializeAuthenticateService alloc] initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        _likeService  = [[SocializeLikeService alloc] initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        _commentsService = [[SocializeCommentsService alloc] initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        _entityService = [[SocializeEntityService alloc]initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        _viewService  = [[SocializeViewService alloc] initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        //        _userService = [[SocializeUserService alloc] initWithProvider:_provider objectFactory:_objectFactory delegate:delegate];
        [_provider release];
    }
    return self;
}

+(void)storeSocializeApiKey:(NSString*) key andSecret: (NSString*)secret;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:key forKey:SOCIALIZE_API_KEY];
    [defaults setValue:secret forKey:SOCIALIZE_API_SECRET];
    [defaults synchronize];
}

+(void)storeFacebookAppId:(NSString*)facebookAppId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:facebookAppId forKey:SOCIALIZE_FACEBOOK_APP_ID];
    [defaults synchronize];
}

+(NSString*) apiKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:SOCIALIZE_API_KEY];
}

+(NSString*) apiSecret
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:SOCIALIZE_API_SECRET];
}

+(NSString*) facebookAppId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:SOCIALIZE_FACEBOOK_APP_ID];
}


#pragma mark authentication info

+(BOOL)handleOpenURL:(NSURL *)url {
    return [SocializeAuthenticateService handleOpenURL:url];
}

-(void)authenticateWithApiKey:(NSString*)apiKey 
          apiSecret:(NSString*)apiSecret
{
   if ([SocializeAuthenticateService isAuthenticated])
       [_authService removeAuthenticationInfo];

   [_authService authenticateWithApiKey:apiKey apiSecret:apiSecret]; 
}

-(void)setDelegate:(id<SocializeServiceDelegate>)delegate{
    _authService.delegate = delegate;
    _likeService.delegate = delegate;
    _commentsService.delegate = delegate;
    _entityService.delegate = delegate;
    _viewService.delegate = delegate;
}

-(void)authenticateWithFacebook {
    NSString *apiKey = [Socialize apiKey];
    NSString *apiSecret = [Socialize apiSecret];
    NSString *facebookAppId = [Socialize facebookAppId];
    
    NSAssert(apiKey != nil, @"Missing api key. API key must be configured before using socialize.");
    NSAssert(apiSecret != nil, @"Missing api secret. API secret must be configured before using socialize.");
    NSAssert(facebookAppId != nil, @"Missing facebook app id. Facebook app id is required to authenticate with facebook.");
    
    [self authenticateWithApiKey:apiKey apiSecret:apiSecret thirdPartyAppId:facebookAppId thirdPartyName:FacebookAuth];
}

-(void)authenticateWithApiKey:(NSString*)apiKey 
                            apiSecret:(NSString*)apiSecret 
                  thirdPartyAuthToken:(NSString*)thirdPartyAuthToken
                     thirdPartyAppId:(NSString*)thirdPartyAppId
                       thirdPartyName:(ThirdPartyAuthName)thirdPartyName
{
    if ([SocializeAuthenticateService isAuthenticated])
        [_authService removeAuthenticationInfo];
    
    [_authService  authenticateWithApiKey:apiKey 
                           apiSecret:apiSecret
                           thirdPartyAuthToken:thirdPartyAuthToken
                           thirdPartyAppId:thirdPartyAppId
                           thirdPartyName:thirdPartyName
    ];
}


-(void)authenticateWithApiKey:(NSString*)apiKey apiSecret:(NSString*)apiSecret
              thirdPartyAppId:(NSString*)thirdPartyAppId 
               thirdPartyName:(ThirdPartyAuthName)thirdPartyName
{
    if ([SocializeAuthenticateService isAuthenticated])
        [_authService removeAuthenticationInfo];
    
    [_authService authenticateWithApiKey:apiKey apiSecret:apiSecret thirdPartyAppId:thirdPartyAppId thirdPartyName:thirdPartyName];
}

-(BOOL)isAuthenticated{
    return [SocializeAuthenticateService isAuthenticated];
}

-(void)removeAuthenticationInfo{
    [_authService removeAuthenticationInfo];
}

#pragma object creation

-(id)createObjectForProtocol:(Protocol *)protocol{
    return [_objectFactory createObjectForProtocol:protocol];
}

#pragma mark like related stuff

-(void)likeEntityWithKey:(NSString*)key longitude:(NSNumber*)lng latitude:(NSNumber*)lat
{
    [_likeService postLikeForEntityKey:key andLongitude:lng latitude:lat]; 
}

-(void)unlikeEntity:(id<SocializeLike>)like
{
    [_likeService deleteLike:like]; 
}

-(void)getLikesForEntityKey:(NSString*)key first:(NSNumber*)first last:(NSNumber*)last{
    [_likeService getLikesForEntityKey:key first:first last:last] ;
}

#pragma comment related  stuff

-(void)getCommentById: (int) commentId{
    [_commentsService getCommentById:commentId];
}

-(void)getCommentList: (NSString*) entryKey first:(NSNumber*)first last:(NSNumber*)last{
    [_commentsService getCommentList:entryKey first:first last:last];
}

-(void)createCommentForEntityWithKey:(NSString*)entityKey comment:(NSString*) comment longitude:(NSNumber*)lng latitude:(NSNumber*)lat{
    [_commentsService createCommentForEntityWithKey:entityKey comment:comment longitude: lng latitude: lat];
}

-(void)createCommentForEntity:(id<SocializeEntity>) entity comment: (NSString*) comment longitude:(NSNumber*)lng latitude:(NSNumber*)lat{
    [_commentsService createCommentForEntity:entity comment:comment longitude: lng latitude: lat];
}

#pragma entity related stuff

-(void)getEntityByKey:(NSString *)entitykey{
    [_entityService entityWithKey:entitykey];
}

-(void)createEntityWithUrl:(NSString*)entityKey andName:(NSString*)name{
    [_entityService createEntityWithKey:entityKey andName:name];
}

#pragma view related stuff

-(void)viewEntity:(id<SocializeEntity>)entity longitude:(NSNumber*)lng latitude: (NSNumber*)lat{
    [_viewService createViewForEntity:entity longitude:lng latitude:lat];
}

@end