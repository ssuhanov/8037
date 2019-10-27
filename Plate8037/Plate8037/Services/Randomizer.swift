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
        let maxNumber:UInt32 = 9
        var firstDigit = Int(arc4random_uniform(maxNumber))
        while firstDigit == .zero {
            firstDigit = Int(arc4random_uniform(maxNumber))
        }
        
        var secondDigit = Int(arc4random_uniform(maxNumber))
        while secondDigit == .zero || secondDigit == firstDigit {
            secondDigit = Int(arc4random_uniform(maxNumber))
        }
        
        var thirdDigit = Int(arc4random_uniform(maxNumber))
        while thirdDigit == .zero || thirdDigit == firstDigit || thirdDigit == secondDigit {
            thirdDigit = Int(arc4random_uniform(maxNumber))
        }
        
        var fourthDigit = Int(arc4random_uniform(maxNumber))
        while fourthDigit == .zero || fourthDigit == thirdDigit || fourthDigit == secondDigit || fourthDigit == firstDigit {
            fourthDigit = Int(arc4random_uniform(maxNumber))
        }
        
        return (firstDigit, secondDigit, thirdDigit, fourthDigit)
    }
}
