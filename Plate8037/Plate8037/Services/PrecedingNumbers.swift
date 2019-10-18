//
//  PrecedingNumbers.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import Foundation

class PrecedingNumbers {
    func getNumbers(for digit: Int) -> [Int] {
        var sign = -1
        var addition = 0
        var addedNumber = digit - 5
        
        var result: [Int] = []
        
        for _ in 0..<4 {
            var nextNumber = addedNumber + sign * addition
            while nextNumber < 0 {
                nextNumber += 10
            }
            
            while nextNumber >= 10 {
                nextNumber -= 10
            }
            
            result.append(nextNumber)
            addedNumber = nextNumber
            
            addition += 2
            sign = -sign
        }
        return result
    }
}
