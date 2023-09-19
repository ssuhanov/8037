//
//  PrecedingNumbersTests.swift
//  Plate8037Tests
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

@testable import Plate8037
import XCTest

class PrecedingNumbersTests: XCTestCase {
  var instance: PrecedingNumbers!

  override func setUp() {
    super.setUp()
    instance = PrecedingNumbers()
  }

  func testCorrectNumbers1() {
    let result = instance.getNumbers(for: 8)
    let correctNumbers = [3, 5, 1, 7]
    XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
  }

  func testCorrectNumbers2() {
    let result = instance.getNumbers(for: 5)
    let correctNumbers = [0, 2, 8, 4]
    XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
  }

  func testCorrectNumbers3() {
    let result = instance.getNumbers(for: 3)
    let correctNumbers = [8, 0, 6, 2]
    XCTAssertEqual(result, correctNumbers, "should be correct numbers: \(correctNumbers)")
  }
}
