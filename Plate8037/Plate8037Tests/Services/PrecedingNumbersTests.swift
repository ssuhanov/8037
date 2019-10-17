//
//  PrecedingNumbersTests.swift
//  Plate8037Tests
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import XCTest
@testable import Plate8037

class PrecedingNumbersTests: XCTestCase {
    var instance: PrecedingNumbers!
    
    override func setUp() {
        instance = PrecedingNumbers()
    }
    
    func testCorrectNumbers1() {
        let result = instance.getNumbers(for: 8)
        let correctNumbers = [3, 4, 2, 5, 1, 6, 0, 7, 9, 8]
        XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
    }

    func testCorrectNumbers2() {
        let result = instance.getNumbers(for: 5)
        let correctNumbers = [0, 1, 9, 2, 8, 3, 7, 4, 6, 5]
        XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
    }

    func testCorrectNumbers3() {
        let result = instance.getNumbers(for: 3)
        let correctNumbers = [8, 9, 7, 0, 6, 1, 5, 2, 4, 3]
        XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
    }
}
