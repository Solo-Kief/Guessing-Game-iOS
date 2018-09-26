//  ViewController.swift
//  Guessing Game iOS
//
//  Created by Solomon Kieffer on 9/21/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var guessAmt: UIProgressView!
    @IBOutlet weak var guessCounter: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var announce: UILabel!
    
    var randNo = 0
    var guessCount = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remote Settings Update
        let settings = Storage.call()
        SettingsViewController.upperBound = settings.0
        SettingsViewController.wins = settings.1
        SettingsViewController.losses = settings.2
        SettingsViewController.doColor = settings.3
        SettingsViewController.hue = settings.4
        //
        
        randNo = Int.random(in: 1...SettingsViewController.upperBound)
        numberField.keyboardType = .numberPad
        titleField.text = "Guess between 1 - \(SettingsViewController.upperBound)"
        if SettingsViewController.doColor {
            self.view.backgroundColor = UIColor.init(hue: CGFloat(SettingsViewController.hue), saturation: 1, brightness: 1, alpha: 1)
        } else {
            self.view.backgroundColor = UIColor.white
        }
        //self.hideKeyboardWhenTappedAround() //See Bottom
    }
    
    @IBAction func Guess(_ sender: Any) {
        guard announce.text != "Try Again?" && announce.text != "Correct" else {
            button.setTitle("Guess", for: .normal)
            announce.text = ""
            randNo = Int.random(in: 1...SettingsViewController.upperBound)
            guessAmt.progress = 1
            guessCount = 8
            guessCounter.text = "8"
            numberField.text = ""
            if SettingsViewController.doColor {
                self.view.backgroundColor = UIColor.init(hue: CGFloat(SettingsViewController.hue), saturation: 1, brightness: 1, alpha: 1)
            } else {
                self.view.backgroundColor = UIColor.white
            }
            return
        }
        
        if SettingsViewController.doColor {
            self.view.backgroundColor = UIColor.init(hue: CGFloat(SettingsViewController.hue), saturation: 1, brightness: 1, alpha: 1)
        } else {
            self.view.backgroundColor = UIColor.white
        }
        
        if button.title(for: .normal) != "Guess" {
            button.setTitle("Guess", for: .normal)
        }
        
        guard let guess = Int(numberField.text!) else {
            self.view.backgroundColor = UIColor.red
            button.setTitle("Guess A Number", for: .normal)
            numberField.text = ""
            return
        }
        
        guard guess >= 1 && guess <= SettingsViewController.upperBound else{
            self.view.backgroundColor = UIColor.red
            button.setTitle("Between 1 and \(SettingsViewController.upperBound)!", for: .normal)
            numberField.text = ""
            return
        }
        
        if guess == randNo {
            self.view.backgroundColor = UIColor.green
            announce.text = "Correct"
            SettingsViewController.addWin()
            view.endEditing(true) //Dismisses the keyboard
        } else if guess > randNo {
            guessAmt.progress -= 0.125
            guessCount -= 1
            guessCounter.text = String(guessCount)
            announce.text = "Too High"
        } else {
            guessAmt.progress -= 0.125
            guessCount -= 1
            guessCounter.text = String(guessCount)
            announce.text = "Too Low"
        }
        
        if guessAmt.progress == 0 {
            view.endEditing(true)
            self.view.backgroundColor = UIColor.red
            announce.text = "Try Again?"
            numberField.text = "It Was: \(randNo)"
            button.setTitle("Retry?", for: .normal)
            SettingsViewController.addLoss()
        }
        
        if announce.text == "Correct" {
            button.setTitle("Play Again?", for: .normal)
        }
    }
}

// https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
