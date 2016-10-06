//
//  SecurityCode.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

public class SecurityCode : NSObject {
    public var length : Int = 0
    public var cardLocation : String!
    public var mode : String!
    
    public override init(){
        super.init()
    }
    
    public class func fromJSON(json : NSDictionary) -> SecurityCode {
        let securityCode : SecurityCode = SecurityCode()
        if let length = JSONHandler.attemptParseToInt(json["length"]){
            securityCode.length = length
        }
        if let cardLocation = JSONHandler.attemptParseToString(json["card_location"]){
            securityCode.cardLocation = cardLocation
        }
        if let mode = JSONHandler.attemptParseToString(json["mode"]){
            securityCode.mode = mode
        }
        return securityCode
    }
    
    public func toJSONString() -> String {
        return JSONHandler.jsonCoding(toJSON())
    }

    public func toJSON() -> [String:Any] {
        let obj:[String:Any] = [
            "length": self.length,
            "cardLocation": self.cardLocation == nil ? "" : self.cardLocation!,
            "mode" : self.mode
        ]
        
        return obj
    }
    
}

public func ==(obj1: SecurityCode, obj2: SecurityCode) -> Bool {
    
    let areEqual =
    obj1.length == obj2.length &&
    obj1.cardLocation == obj2.cardLocation &&
    obj1.mode == obj2.mode
    
    return areEqual
}
