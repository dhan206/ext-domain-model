//
//  DoubleExtensionTest.swift
//  ExtDomainModel
//
//  Created by Derek Han on 4/13/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import XCTest

import ExtDomainModel

class DoubleExtensionTest: XCTestCase {
    
    func testDoubleExtenstion() {
        let result1 = (10.0).USD
        XCTAssert(result1.amount == 10)
        XCTAssert(result1.currency == "USD")
        
        let result2 = 5.YEN
        XCTAssert(result2.amount == 5)
        XCTAssert(result2.currency == "YEN")
        
        let result3 = (10.0).GBP
        XCTAssert(result3.amount == 10)
        XCTAssert(result3.currency == "GBP")
        
        let result4 = result1 + result3
        XCTAssert(result4.amount == 15)
        XCTAssert(result4.currency == "GBP")
        
        let result5 = result1.convert("GBP")
        XCTAssert(result5.amount == 5)
        XCTAssert(result5.currency == "GBP")
    }
}
