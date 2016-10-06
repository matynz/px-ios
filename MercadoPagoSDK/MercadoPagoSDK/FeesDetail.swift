//
//  FeesDetail.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 6/3/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

public class FeesDetail : NSObject {
    public var amount : Double = 0
    public var amountRefunded : Double = 0
    public var feePayer : String!
    public var type : String!
    
    public class func fromJSON(json : NSDictionary) -> FeesDetail {
        let fd : FeesDetail = FeesDetail()
        if let type = JSONHandler.attemptParseToString(json["type"]){
            fd.type = type
        }
        if let feePayer = JSONHandler.attemptParseToString(json["fee_payer"]){
            fd.feePayer = feePayer
        }
        if let amount = JSONHandler.attemptParseToDouble(json["amount"]){
            fd.amount = amount
        }
        if let amountRefunded = JSONHandler.attemptParseToDouble(json["amount_refunded"]){
            fd.amountRefunded = amountRefunded
        }
        return fd
    }
    
    func isFinancingFeeType() -> Bool {
        return self.type == "financing_fee"
    }
    
    public func toJSONString() -> String {
        let obj:[String:Any] = [
            "type": self.type != nil ? JSONHandler.null : self.type!,
            "amountRefunded" : self.amountRefunded,
            "amount" : self.amount,
            "type" : self.type
            ]
        return JSONHandler.jsonCoding(obj)
    }
    
}

public func ==(obj1: FeesDetail, obj2: FeesDetail) -> Bool {
    
    let areEqual =
        obj1.amount == obj2.amount &&
        obj1.amountRefunded == obj2.amountRefunded &&
        obj1.feePayer == obj2.feePayer &&
        obj1.type == obj2.type
    return areEqual
}
