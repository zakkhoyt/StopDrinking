//
//  RKOAuthCredential.h
//  Pods
//
//  Created by Sam Symons on 2015-05-03.
//
//

#import <Foundation/Foundation.h>

@class RKAccessToken;

@interface RKOAuthCredential : NSObject

/**
 The OAuth client identifier from reddit's OAuth application page.

 @note This is a fixed value generated by reddit when the application is configured.
 */
@property (nonatomic, strong) NSString *clientIdentifier;

/**
 The OAuth redirect URI from reddit's OAuth application page.
 */
@property (nonatomic, strong) NSURL *redirectURI;

/**
 The OAuth authorization code returned by reddit's callback to the current app.

 @note This is used when retrieving an access token.
 */
@property (nonatomic, strong) NSString *authorizationCode;

/**
 The OAuth access token returned by reddit.

 @note This is used when making authenticated requests to the reddit API.
 */
@property (nonatomic, strong) RKAccessToken *accessToken;

@end