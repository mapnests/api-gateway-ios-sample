//
//  TNApiGatewayCrypto.h
//  TNMapSDK
//
//  Created by TechnoNext
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNApiGatewayCrypto : NSObject

#pragma mark - Public Encrypt Methods

/// Encrypts a JSON string and returns a dictionary containing cf-cid (AES-GCM encrypted message)
/// and cf-csid (RSA-OAEP encrypted AES key) ready for HTTP headers
+ (NSDictionary<NSString *, NSString *> *)encryptPayloadForHeaders:(NSString *)jsonString
                                                  withPublicKeyPEM:(NSString *)publicKeyPEM
                                                              error:(NSError * _Nullable * _Nullable)error;

/// Fetches server time (uses Kronos internally)
+ (NSTimeInterval)fetchServerTime;

@end

NS_ASSUME_NONNULL_END
