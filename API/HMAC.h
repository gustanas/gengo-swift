//
//  HMAC.h
//  r53
//
//  Created by Sascha Holesch on 2014/06/10.
//  Copyright (c) 2014年 Eyes, JAPAN. All rights reserved.
//  Based on http://stackoverflow.com/questions/24099520/commonhmac-in-swift.

#import <Foundation/Foundation.h>

@interface HMAC : NSObject

typedef NS_ENUM(NSInteger, HMACAlgorithm)
{
    SHA1,
    MD5,
    SHA256,
    SHA384,
    SHA512,
    SHA224
};

/*
 @param key The salt to encode the data with.
 @param data The data to encode.
 @return RAW HMAC data.
 */
+ (NSData *)calculateWithAlgorithm:(HMACAlgorithm)algorithm forKey:(NSString *)key andData:(NSString *)data;

/*
 @param algorithm: The enum representing the algorithm.
 @return Digest length
 */
+ (NSInteger)digestLengthForAlgorithm:(HMACAlgorithm)algorithm;

+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;

@end