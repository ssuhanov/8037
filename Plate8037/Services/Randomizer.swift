//
//  Randomizer.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import Foundation

class Randomizer {
  // swiftlint:disable:next large_tuple
  func getDigits() -> (Int, Int, Int, Int) {
    let maxNumber = 9
    var firstDigit = Int.random(in: 1...maxNumber)
    while firstDigit == .zero {
      firstDigit = Int.random(in: 1...maxNumber)
    }

    var secondDigit = Int.random(in: 1...maxNumber)
    while secondDigit == .zero || secondDigit == firstDigit {
      secondDigit = Int.random(in: 1...maxNumber)
    }

    var thirdDigit = Int.random(in: 1...maxNumber)
    while thirdDigit == .zero || thirdDigit == firstDigit || thirdDigit == secondDigit {
      thirdDigit = Int.random(in: 1...maxNumber)
    }

    var fourthDigit = Int.random(in: 1...maxNumber)
    while fourthDigit == .zero || fourthDigit == thirdDigit || fourthDigit == secondDigit || fourthDigit == firstDigit {
      fourthDigit = Int.random(in: 1...maxNumber)
    }

    return (firstDigit, secondDigit, thirdDigit, fourthDigit)
  }
}
