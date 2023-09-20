//
//  ViewController.swift
//  Plate8037
//
//  Created by Serge Sukhanov on 10/17/2019.
//  Copyright © 2019 Serge Sukhanov. All rights reserved.
//

import UIKit

private enum Constants {
  static let signShowingDuration: TimeInterval = 2.0
  static let signShowingInterval: TimeInterval = 5.0
}

class ViewController: UIViewController {
  private var answer: Int = 0 {
    didSet {
      answerLabel.text = (answer == 0) ? "" : "\(answer)"
    }
  }

  private var correctAnswer: Int = 0

  private var keyboardIsActive: Bool = false

  private var signsAnimationTimer: Timer?

  @IBOutlet var firstDigitLabel: UILabel!
  @IBOutlet var secondDigitLabel: UILabel!
  @IBOutlet var thirdDigitLabel: UILabel!
  @IBOutlet var fourthDigitLabel: UILabel!

  @IBOutlet var firstSignLabel: UILabel!
  @IBOutlet var secondSignLabel: UILabel!
  @IBOutlet var thirdSignLabel: UILabel!

  @IBOutlet var answerLabel: UILabel!

  #warning("TODO: - should be a separate class RoundCornerButton and these outlets shold be gone")
  @IBOutlet var zeroDigitButton: UIButton!
  @IBOutlet var oneDigitButton: UIButton!
  @IBOutlet var twoDigitButton: UIButton!
  @IBOutlet var threeDigitButton: UIButton!
  @IBOutlet var fourDigitButton: UIButton!
  @IBOutlet var fiveDigitButton: UIButton!
  @IBOutlet var sixDigitButton: UIButton!
  @IBOutlet var sevenDigitButton: UIButton!
  @IBOutlet var eightDigitButton: UIButton!
  @IBOutlet var nineDigitButton: UIButton!

  @IBOutlet var alertBackgroundView: UIView!
  @IBOutlet var alertView: UIView!
  @IBOutlet var alertTitleLabel: UILabel!
  @IBOutlet var alertDescriptionLabel: UILabel!
  @IBOutlet var alertButton: UIButton!

  override var preferredStatusBarStyle: UIStatusBarStyle {
    .darkContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    firstSignLabel.alpha = .zero
    secondSignLabel.alpha = .zero
    thirdSignLabel.alpha = .zero
    alertBackgroundView.alpha = .zero
    alertBackgroundView.isHidden = true
    alertView.alpha = .zero
    alertView.isHidden = true

    roundCorners(view: zeroDigitButton)
    roundCorners(view: oneDigitButton)
    roundCorners(view: twoDigitButton)
    roundCorners(view: threeDigitButton)
    roundCorners(view: fourDigitButton)
    roundCorners(view: fiveDigitButton)
    roundCorners(view: sixDigitButton)
    roundCorners(view: sevenDigitButton)
    roundCorners(view: eightDigitButton)
    roundCorners(view: nineDigitButton)

    roundCorners(view: alertView)
    roundCorners(view: alertButton)
  }

  private func roundCorners(view: UIView) {
    view.layer.cornerRadius = 8.0
    view.layer.masksToBounds = true
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
      self?.animateSignsAndDigits()
      self?.signsAnimationTimer?.invalidate()
      self?.signsAnimationTimer = Timer.scheduledTimer(
        withTimeInterval: Constants.signShowingInterval,
        repeats: true
      ) { _ in
        self?.animateSignsAndDigits()
      }
    }
  }

  private func animateSignsAndDigits() {
    guard keyboardIsActive else {
      return
    }

    animateSign()
    animateDigits()
  }

  private func animateSign() {
    showSign(signLabel: secondSignLabel)
  }

  private func showSign(signLabel: UILabel) {
    UIView.animate(
      withDuration: Constants.signShowingDuration / 3.0,
      animations: { signLabel.alpha = 1.0 },
      completion: { [weak self] _ in
        self?.hideSign(signLabel: signLabel, withDelay: Constants.signShowingDuration / 3.0)
      }
    )
  }

  private func hideSign(signLabel: UILabel, withDelay delay: TimeInterval) {
    UIView.animate(
      withDuration: Constants.signShowingDuration / 3.0,
      delay: delay,
      animations: { signLabel.alpha = .zero }
    )
  }

  private func animateDigits() {
    moveDigits()
  }

  private func moveDigits() {
    UIView.animate(
      withDuration: Constants.signShowingDuration / 3.0,
      animations: { [weak self] in
        let translationValue: CGFloat = 15.0
        let transform1 = CGAffineTransform(translationX: translationValue, y: .zero)
        let transform2 = CGAffineTransform(translationX: -translationValue, y: .zero)
        self?.firstDigitLabel.transform = transform1
        self?.secondDigitLabel.transform = transform2
        self?.thirdDigitLabel.transform = transform1
        self?.fourthDigitLabel.transform = transform2
      },
      completion: { [weak self] _ in self?.returnDigits(withDelay: Constants.signShowingDuration / 3.0) }
    )
  }

  private func returnDigits(withDelay delay: TimeInterval) {
    UIView.animate(
      withDuration: Constants.signShowingDuration / 3.0,
      delay: delay,
      animations: { [weak self] in
        let transform = CGAffineTransform(translationX: .zero, y: .zero)
        self?.firstDigitLabel.transform = transform
        self?.secondDigitLabel.transform = transform
        self?.thirdDigitLabel.transform = transform
        self?.fourthDigitLabel.transform = transform
      }
    )
  }

  @IBAction private func numberButtonPressed(_ sender: UIButton) {
    guard keyboardIsActive else {
      return
    }

    answer *= 10
    answer += sender.tag

    if answer == correctAnswer {
      showAlertView(type: .correctAnswer)
    } else if answer >= correctAnswer {
      showAlertView(type: .wrongAnswer)
    }
  }

  @IBAction private func alertButtonPressed(_: UIButton) {
    hideAlertViewWithAnimation()
    startAgain()
  }

  enum AlertType {
    case correctAnswer
    case wrongAnswer
  }

  private func showAlertView(type: AlertType) {
    signsAnimationTimer?.invalidate()
    let correctTitles = ["HOORAY!", "YEAAAH!", "CORRECT!"]
    let incorrectTitles = ["SORRY", "OH, NO", "NOT THIS TIME"]

    let titleIndex = Int(UInt32.random(in: 0..<UInt32.max) % 3)

    switch type {
    case .correctAnswer:
      alertTitleLabel.text = correctTitles[titleIndex]
      alertDescriptionLabel.text = "You're right!"
      alertButton.setTitle("The next", for: .normal)
    case .wrongAnswer:
      alertTitleLabel.text = incorrectTitles[titleIndex]
      alertDescriptionLabel.text = "You can do better!"
      alertButton.setTitle("Try again", for: .normal)
    }

    showAlertViewWithAnimation()
  }

  private func showAlertViewWithAnimation() {
    alertBackgroundView.isHidden = false
    alertView.isHidden = false
    alertView.transform = CGAffineTransform(translationX: .zero, y: 160.0)
    UIView.animate(
      withDuration: 0.2,
      animations: { [weak self] in
        self?.alertBackgroundView.alpha = 0.66
        self?.alertView.alpha = 1.0
        self?.alertView.transform = CGAffineTransform(translationX: .zero, y: .zero)
      }
    )
  }

  private func hideAlertViewWithAnimation() {
    UIView.animate(
      withDuration: 0.2,
      animations: { [weak self] in
        self?.alertBackgroundView.alpha = .zero
        self?.alertView.alpha = .zero
      },
      completion: { [weak self] _ in
        self?.alertBackgroundView.isHidden = true
        self?.alertView.isHidden = true
      }
    )
  }
}

extension UILabel {
  func assignWithAnimation(digit: Int, animationGroup: DispatchGroup) {
    animationGroup.enter()
    let precedingNumbers = PrecedingNumbers().getNumbers(for: digit)
    let animationDuration: TimeInterval = 0.2 + Double(UInt32.random(in: 0..<UInt32.max) % 200) / 1000
    let disappearAnimation: () -> Void = { [weak self] in
      self?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
      self?.alpha = .zero
    }
    UIView.animate(
      withDuration: animationDuration,
      animations: disappearAnimation,
      completion: { [weak self] _ in
        self?.animate(
          digit: digit,
          precedingNumbers: precedingNumbers,
          animationGroup: animationGroup
        )
      }
    )
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
    let animationDuration: TimeInterval = 0.2 + Double(UInt32.random(in: 0..<UInt32.max) % 200) / 1000
    if let nextNumber = precedingNumbers.first {
      precedingNumbers = Array(precedingNumbers.dropFirst())

      text = "\(nextNumber)"
      UIView.animate(
        withDuration: animationDuration,
        delay: .zero,
        options: .curveEaseIn,
        animations: appearAnimation,
        completion: { [weak self] _ in
          UIView.animate(
            withDuration: animationDuration,
            delay: .zero,
            options: .curveEaseOut,
            animations: disappearAnimation,
            completion: { _ in
              self?.animate(
                digit: digit,
                precedingNumbers: precedingNumbers,
                animationGroup: animationGroup
              )
            }
          )
        }
      )
    } else {
      text = "\(digit)"
      UIView.animate(
        withDuration: animationDuration,
        animations: appearAnimation,
        completion: { _ in animationGroup.leave() }
      )
    }
  }
}
