//
//  main.swift
//  ExtDomainModel
//
//  Created by Derek Han on 4/12/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

protocol Mathematics {
    static func +(firstMoney: Self, secondMoney: Self) -> Self
    static func -(firstMoney: Self, secondMoney: Self) -> Self
}

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
    }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    // String representation of money
    public var description: String {
        return "\(currency)\(Double(amount))";
    }
    
    // Converts money to/from USB, GBP, EURO, and CAN
    public func convert(_ to: String) -> Money {
        let currentAmount = Double(self.amount)
        var amountConverted : Double
        if ( self.currency == "USD" ) { // USD to __
            if (to == "GBP") { // USD to GBP
                amountConverted = currentAmount * 0.5
            } else if (to == "EUR") { // USD to EUR
                amountConverted = currentAmount * 1.5
            } else if (to == "CAN"){ // USD to CAN
                amountConverted = currentAmount * 1.25
            } else { // Unknwon currency
                return self
            }
        } else if ( self.currency == "EUR" ) { // EUR to __
            if (to == "USD") { // EUR to USD
                amountConverted = currentAmount * (2.0/3.0)
            } else if (to == "GBP") { // EUR to GBP
                amountConverted = currentAmount * (1.0/3.0)
            } else if (to == "CAN") { // EUR to CAN
                amountConverted = currentAmount * (5.0/6.0)
            } else { // Unknwon currency
                return self
            }
        } else if ( self.currency == "CAN" ){ // CAN to __
            if (to == "USD") { // CAN to USD
                amountConverted = currentAmount * 0.8
            } else if (to == "GBP") { // CAN to GBP
                amountConverted = currentAmount * 0.4
            } else if (to == "EUR"){ // CAN to EUR
                amountConverted = currentAmount * 1.2
            } else { // Unknwon currency
                return self
            }
        } else if ( self.currency == "GBP" ){ // GBP to __
            if (to == "USD") { // GBP to USD
                amountConverted = currentAmount * 2.0
            } else if (to == "EUR") { // GBP to EUR
                amountConverted = currentAmount * 3.0
            } else if (to == "CAN" ){ // GBP to CAN
                amountConverted = currentAmount * 2.5
            } else { // Unknwon currency
                return self
            }
        } else { // Unknwon currency
            return self
        }
        return Money(amount: Int(amountConverted), currency: to)
    }
    
    // Adds money. Returns money in currency of passed money.
    public func add(_ to: Money) -> Money {
        var thisMoney = self
        if self.currency != to.currency { // Only convert if adding to different currency
            thisMoney = thisMoney.convert(to.currency)
        }
        return Money(amount: thisMoney.amount + to.amount, currency: to.currency)
    }
    
    // Subtracts money. Returns money in currency of passed money.
    public func subtract(_ from: Money) -> Money {
        var thisMoney = self
        if self.currency != from.currency { // Only convert if adding to different currency
            thisMoney = thisMoney.convert(from.currency)
        }
        return Money(amount: from.amount - thisMoney.amount, currency: from.currency)
    }
    
    static func +(firstMoney: Money, secondMoney: Money) -> Money {
        return firstMoney.add(secondMoney)
    }
    
    static func -(firstMoney: Money, secondMoney: Money) -> Money {
        return firstMoney.subtract(secondMoney)
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    public var description: String {
        var pay: String = "";
        switch self.type {
        case .Hourly(let rate): pay = "$\(rate) per hour";
        case .Salary(let income): pay = "$\(Double(income)) salary"
        }
        
        return "\(title) @ \(pay)"
    }
    // Calculates income based on salary or hourly rate
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let rate): return Int(rate * Double(hours))
        case .Salary(let income): return income
        }
    }
    
    // Raises the the salary or hourly rate with passed amount
    open func raise(_ amt : Double) {
        switch self.type {
        case .Salary(let income): self.type = .Salary(Int(Double(income) + amt))
        case .Hourly(let rate): self.type = .Hourly(rate + amt)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    // Person's job
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return self._job }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }
    
    // Person's spouse
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return self._spouse }
        set(value) {
            if self.age >= 18 && (value?.age)! >= 18 { // Both to-be spouses must be 18 or older
                self._spouse = value
            }
        }
    }
    
    public var description: String {
        var jobString: String
        var spouseString: String
        
        if (self._job == nil) {
            jobString = "Not employed"
        } else {
            jobString = "Occupation: " + (self._job?.description)!
        }
        
        if (self._spouse == nil) {
            spouseString = "Not married"
        } else {
            spouseString = "Married to " + (self._spouse?.firstName)! + " " + (self._spouse?.lastName)!;
        }
        
        return "\(self.firstName) \(self.lastName), \(self.age), \(jobString), \(spouseString)"
        
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    // String representation of person in the form: '[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]'
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.title ?? "nil") spouse:\(self._spouse?.firstName ?? "nil")]"
    }
}

////////////////////////////////////
// Family
//
open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
        self.members.append(spouse1)
        self.members.append(spouse2)
        
        if spouse1.age <= 21 && spouse2.age <= 21 { // Must have a family member that is >21 years old
            self.members.append(Person(firstName: "Legal", lastName: "Guardian", age: 22))
        }
    }
    
    public var description: String {
        var familyString: String = ""
        for person in members {
            familyString += "Name: \(person.firstName) \(person.lastName), ";
        }
        familyString += "Total family income: $\(String(householdIncome()))";
        
        
        return familyString
    }
    
    // Adds child to family and sets their age to 0
    open func haveChild(_ child: Person) -> Bool {
        let newChild = child
        newChild.age = 0
        self.members.append(newChild)
        return true
    }
    
    // Returns the combined income of a household
    open func householdIncome() -> Int {
        var totalIncome = 0
        for member in members {
            if member.job != nil {
                totalIncome += (member.job?.calculateIncome(2000))!
            }
        }
        return totalIncome
    }
}
