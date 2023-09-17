//
//  Randomizer.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import Foundation

class Randomizer {
    func getDigits() -> (Int, Int, Int, Int) {
        var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
        let firstDigit = numbers[0]
        numbers = Array(numbers.dropFirst()).shuffled()
        let secondDigit = numbers[0]
        numbers = Array(numbers.dropFirst())
        let thirdDigit = numbers[0]
        numbers = Array(numbers.dropFirst())
        let fourthDigit = numbers[0]
        return (firstDigit, secondDigit, thirdDigit, fourthDigit)
    }
}
