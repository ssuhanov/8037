//
//  ViewController.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var answer: Int = 0 {
        didSet {
            answerLabel.text = (answer == 0) ? "" : "\(answer)"
        }
    }
    private var correctAnswer: Int = 0
    
    private var keyboardIsActive: Bool = false
    
    @IBOutlet weak var firstDigitLabel: UILabel!
    @IBOutlet weak var secondDigitLabel: UILabel!
    @IBOutlet weak var thirdDigitLabel: UILabel!
    @IBOutlet weak var fourthDigitLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAgain()
    }
    
    private func startAgain() {
        let digits = Randomizer().getDigits()
        let resultChecker = ResultChecker(digits: digits)
        
        answer = 0
        correctAnswer = resultChecker.correctAnswer()
        let animationGroup = DispatchGroup()
        keyboardIsActive = false

        firstDigitLabel.assignWithAnimation(digit: digits.0, animationGroup: animationGroup)
        secondDigitLabel.assignWithAnimation(digit: digits.1, animationGroup: animationGroup)
        thirdDigitLabel.assignWithAnimation(digit: digits.2, animationGroup: animationGroup)
        fourthDigitLabel.assignWithAnimation(digit: digits.3, animationGroup: animationGroup)
        
        animationGroup.notify(queue: .main) { [weak self] in
            self?.keyboardIsActive = true
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard keyboardIsActive else {
            return
        }
        
        answer *= 10
        answer += sender.tag
        
        if answer == correctAnswer {
            showAlert(title: "CONGRATULATIONS!", message: "You're right!")
            startAgain()
        } else if answer >= correctAnswer {
            showAlert(title: "SORRY", message: "You're wrong, try again")
            startAgain()
        }
    }
}

extension UILabel {
    func assignWithAnimation(digit: Int, animationGroup: DispatchGroup) {
        animationGroup.enter()
        let precedingNumbers = PrecedingNumbers().getNumbers(for: digit)
        let animationDuration: TimeInterval = 0.2 + Double(arc4random() % 200) / 1000
        let disappearAnimation: () -> Void = { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.alpha = .zero
        }
        UIView.animate(withDuration: animationDuration,
                       animations: disappearAnimation,
                       completion: { [weak self] _ in self?.animate(digit: digit,
                                                                    precedingNumbers: precedingNumbers,
                                                                    animationGroup: animationGroup) })
    }
    
    private func animate(digit: Int, precedingNumbers: [Int], animationGroup: DispatchGroup) {
        transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        alpha = .zero
        
        let appearAnimation: () -> Void = { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self?.alpha = 1.0
        }
        
        let disappearAnimation: () -> Void = { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self?.alpha = .zero
        }
        var precedingNumbers = precedingNumbers
        let animationDuration: TimeInterval = 0.2 + Double(arc4random() % 200) / 1000
        if let nextNumber = precedingNumbers.first {
            precedingNumbers = Array(precedingNumbers.dropFirst())

            text = "\(nextNumber)"
            UIView.animate(withDuration: animationDuration,
                           delay: .zero,
                           options: .curveEaseIn,
                           animations: appearAnimation,
                           completion: { [weak self] _ in
                            
                            UIView.animate(withDuration: animationDuration,
                                           delay: .zero,
                                           options: .curveEaseOut,
                                           animations: disappearAnimation,
                                           completion: { _ in self?.animate(digit: digit,
                                                                            precedingNumbers: precedingNumbers,
                                                                            animationGroup: animationGroup) })
            })
        } else {
            text = "\(digit)"
            UIView.animate(withDuration: animationDuration,
                           animations: appearAnimation,
                           completion: { _ in animationGroup.leave() })
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak alertController] in
                alertController?.dismiss(animated: true, completion: nil)
            }
        }
    }

}
