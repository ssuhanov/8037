//
//  ResultChecker.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import Foundation

class ResultChecker {
  // swiftlint:disable:next large_tuple
  var digits: (Int, Int, Int, Int)

  // swiftlint:disable:next large_tuple
  init(digits: (Int, Int, Int, Int)) {
    self.digits = digits
  }

  func correctAnswer() -> Int {
    return digits.0 * 10 + digits.1 + digits.2 * 10 + digits.3
  }
}
