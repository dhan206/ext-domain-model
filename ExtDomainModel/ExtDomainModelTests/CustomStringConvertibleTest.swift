//
//  CustomStringConvertibleTest.swift
//  ExtDomainModel
//
//  Created by Derek Han on 4/13/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import XCTest

import ExtDomainModel

// CustomStringConvertible Test
class CustomStringConvertibleTest: XCTestCase {
    
    func testMoneyCustomStringConvertible() {
        let tenUSD = Money(amount: 10, currency: "USD");
        let fifteenCAN = Money(amount: 15, currency: "CAN");
        let fifteenEUR = Money(amount: 15, currency: "EUR");
        
        XCTAssert(tenUSD.description == "USD10.0");
        XCTAssert(fifteenCAN.description == "CAN15.0");
        XCTAssert(fifteenEUR.description == "EUR15.0");
    }

    func testJobCustomStringConvertible() {
        let job1 = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        let job2 = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        
        XCTAssert(job1.description == "Guest Lecturer @ $1000.0 salary");
        XCTAssert(job2.description == "Janitor @ $15.0 per hour");
    }
    
    // return "\(self.firstName) \(self.lastName), \(self.age), \(jobString), \(spouseString)"

    func testPersonCustomStringConvertible() {
        let harry = Person(firstName: "Harry", lastName: "Potter", age: 21)
        harry.job = Job(title: "Wizard", type: Job.JobType.Salary(1000000))
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)
        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        
        XCTAssert(harry.description == "Harry Potter, 21, Occupation: Wizard @ $1000000.0 salary, Not married");
        XCTAssert(mike.description == "Michael Neward, 22, Not employed, Married to Bambi Jones");
    }
    
    func testFamilyCustomStringConvertible() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let family1 = Family(spouse1: ted, spouse2: charlotte)
        
        XCTAssert(family1.description == "Name: Ted Neward, Name: Charlotte Neward, Total family income: $1000");
        
        let bob = Person(firstName: "Bob", lastName: "The Builder", age: 29)
        bob.job = Job(title: "Builder", type: Job.JobType.Salary(1000))
        let cindy = Person(firstName: "Cindy", lastName: "The Architect", age: 26)
        cindy.job = Job(title: "Architect", type: Job.JobType.Hourly(30.0))
        let family2 = Family(spouse1: bob, spouse2: cindy)
        let bobby = Person(firstName: "Bobby", lastName: "The Builder", age: 0)
        let _ = family2.haveChild(bobby)
        
        XCTAssert(family2.description == "Name: Bob The Builder, Name: Cindy The Architect, Name: Bobby The Builder, Total family income: $61000")
    }
}
