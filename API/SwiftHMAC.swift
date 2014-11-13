//
//  SwiftHMAC.swift
//  r53
//
//  Created by Sascha Holesch on 2014/06/11.
//  Copyright (c) 2014年 Eyes, JAPAN. All rights reserved.
//

import Foundation

/*
Wrapper class for creating HMAC. Based on http://stackoverflow.com/questions/24099520/commonhmac-in-swift.
*/
class SwiftHMAC
{
    /*
    @param key The salt to encode the data with.
    @param data The data to encode.
    @return Base64 encoded HMAC.
    */
    func calculate(algorithm:HMACAlgorithm, key:String, data:String) -> String
    {
        let computedHMAC = HMAC.calculateWithAlgorithm(algorithm, forKey:key, andData:data)
        var base64EncodedHMAC = computedHMAC.base64EncodedStringWithOptions(nil)
        
        return base64EncodedHMAC
    }
    
    func hmac(text: String, key:String) -> String{
        return HMAC.hmacsha1(text, key:key)
    }
}