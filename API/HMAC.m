//
//  HMAC.m
//  r53
//
//  Created by Sascha Holesch on 2014/06/10.
//  Copyright (c) 2014年 Eyes, JAPAN. All rights reserved.
//  Based on http://stackoverflow.com/questions/24099520/commonhmac-in-swift.


#import "HMAC.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation HMAC

+ (NSData *)calculateWithAlgorithm:(HMACAlgorithm)algorithm forKey:(NSString *)key andData:(NSString *)data
{
    // Parse the parameters into c strings.
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    
    // Retrieve the digest length for the specified algorithm and prepare the variable to hold the HMAC data
    NSInteger digestLength = [self digestLengthForAlgorithm:algorithm];
    unsigned char hmac[digestLength];
    
    // Calculate the HMAC and save the result in a NSData object
    CCHmac(algorithm, cKey, strlen(cKey), cData, strlen(cData), &hmac);
    NSData *hmacBytes = [NSData dataWithBytes:hmac length:sizeof(hmac)];
    
    return hmacBytes;
}

+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret {
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [text cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    return HMAC;
}

+ (NSInteger)digestLengthForAlgorithm:(HMACAlgorithm)algorithm
{
    switch (algorithm)
    {
        case MD5: return CC_MD5_DIGEST_LENGTH;
        case SHA1: return CC_SHA1_DIGEST_LENGTH;
        case SHA224: return CC_SHA224_DIGEST_LENGTH;
        case SHA256: return CC_SHA256_DIGEST_LENGTH;
        case SHA384: return CC_SHA384_DIGEST_LENGTH;
        case SHA512: return CC_SHA512_DIGEST_LENGTH;
        default: return 0;
    }
}

@end