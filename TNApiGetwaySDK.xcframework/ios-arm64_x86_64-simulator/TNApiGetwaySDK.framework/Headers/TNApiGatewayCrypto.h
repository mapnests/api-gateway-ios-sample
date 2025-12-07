
//
//  TNApiGatewayCrypto.h.swift
//  TNMapSDK
//
//  Created by TechnoNext on 4/12/25.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNApiGatewayCrypto : NSObject

/// Encrypt jsonString using publicKeyPEM (PEM text OR base64 encoded PEM)
+ (NSString *)encryptPayload:(NSString *)jsonString
            withPublicKeyPEM:(NSString *)publicKeyPEM
                        error:(NSError * _Nullable * _Nullable)error;

@end

NS_ASSUME_NONNULL_END

