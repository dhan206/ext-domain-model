//
//  MathematicsProtocolTest.swift
//  ExtDomainModel
//
//  Created by Derek Han on 4/13/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import XCTest

import ExtDomainModel

// Mathematics Protocol Test on Money Class
class MathematicsProtocolTest: XCTestCase {
    
    func testMathmaticsProtocol() {
        let tenUSD = Money(amount: 10, currency: "USD")
        let fiveGBP = Money(amount: 5, currency: "GBP")
        let fifteenEUR = Money(amount: 15, currency: "EUR")
        
        let result1 = fiveGBP + fifteenEUR
        XCTAssert(result1.amount == 30)
        XCTAssert(result1.currency == "EUR")
        
        let result2 = tenUSD + tenUSD
        XCTAssert(result2.amount == 20)
        XCTAssert(result2.currency == "USD")
        
        let result3 = tenUSD - fiveGBP
        XCTAssert(result3.amount == 0)
        XCTAssert(result3.currency == "GBP")
    }
}
