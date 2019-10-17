//
//  RandomizerTests.swift
//  Plate8037Tests
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import XCTest
@testable import Plate8037

class RandomizerTests: XCTestCase {
    var instance: Randomizer!
    
    override func setUp() {
        instance = Randomizer()
    }
    
    func testAllDigitsAreDifferent() {
        let result = instance.getDigits()
        XCTAssertNotEqual(result.0, result.1, "first and second digits should be different")
        XCTAssertNotEqual(result.0, result.2, "first and third digits should be different")
        XCTAssertNotEqual(result.0, result.3, "first and fourth digits should be different")
        XCTAssertNotEqual(result.1, result.2, "second and third digits should be different")
        XCTAssertNotEqual(result.1, result.3, "second and fourth digits should be different")
        XCTAssertNotEqual(result.2, result.3, "third and fourth digits should be different")
    }
    
    func testAllDigitsAreNotZero() {
        let result = instance.getDigits()
        XCTAssertNotEqual(result.0, .zero, "first digit should be not a zero")
        XCTAssertNotEqual(result.1, .zero, "second digit should be not a zero")
        XCTAssertNotEqual(result.2, .zero, "third digit should be not a zero")
        XCTAssertNotEqual(result.3, .zero, "fourth digit should be not a zero")
    }
}
