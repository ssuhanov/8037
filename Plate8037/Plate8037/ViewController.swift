//
//  ViewController.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstDigitLabel: UILabel!
    @IBOutlet weak var secondDigitLabel: UILabel!
    @IBOutlet weak var thirdDigitLabel: UILabel!
    @IBOutlet weak var fourthDigitLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let digits = Randomizer().getDigits()
        firstDigitLabel.text = "\(digits.0)"
        secondDigitLabel.text = "\(digits.1)"
        thirdDigitLabel.text = "\(digits.2)"
        fourthDigitLabel.text = "\(digits.3)"
    }
}

