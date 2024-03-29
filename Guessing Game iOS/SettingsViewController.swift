//
//  SettingsViewController.swift
//  Guessing Game iOS
//
//  Created by Solomon Keiffer on 9/25/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var upperBoundField: UITextField!
    @IBOutlet weak var winCount: UITextField!
    @IBOutlet weak var loseCount: UITextField!
    @IBOutlet weak var doColorize: UISwitch!
    @IBOutlet weak var colorHue: UISlider!
    
    static public var hue: Float = 0.5
    static public var doColor = false
    static public var upperBound = 100
    static public var wins = 0
    static public var losses = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        upperBoundField.keyboardType = .numberPad
        
        let settings = Storage.call()
        SettingsViewController.upperBound = settings.0
        SettingsViewController.wins = settings.1
        SettingsViewController.losses = settings.2
        SettingsViewController.doColor = settings.3
        SettingsViewController.hue = settings.4
        
        upperBoundField.text = String(SettingsViewController.upperBound)
        winCount.text = String(SettingsViewController.wins)
        loseCount.text = String(SettingsViewController.losses)
        doColorize.isOn = SettingsViewController.doColor
        colorHue.value = SettingsViewController.hue
        
        if SettingsViewController.doColor {
            self.view.backgroundColor = UIColor.init(hue: CGFloat(SettingsViewController.hue), saturation: 1, brightness: 1, alpha: 1)
        } else {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func update(_ sender: Any) {
        guard var updateUpperBound = Int(upperBoundField.text!) else {
            upperBoundField.text = "Invalid Input"
            return
        }
        if updateUpperBound < 25 {
            updateUpperBound = 25
            upperBoundField.text = "25"
        }
        if updateUpperBound > 1000 {
            updateUpperBound = 1000
            upperBoundField.text = "1000"
        }
        SettingsViewController.upperBound = updateUpperBound
        Storage.push(upperBound: SettingsViewController.upperBound, wins: SettingsViewController.wins, losses: SettingsViewController.losses, isColorized: SettingsViewController.doColor, colorHue: SettingsViewController.hue)
    }
    
    static public func addWin() {
        wins += 1
        Storage.push(upperBound: SettingsViewController.upperBound, wins: SettingsViewController.wins, losses: SettingsViewController.losses, isColorized: SettingsViewController.doColor, colorHue: SettingsViewController.hue)
    }
    
    static public func addLoss() {
        losses += 1
        Storage.push(upperBound: SettingsViewController.upperBound, wins: SettingsViewController.wins, losses: SettingsViewController.losses, isColorized: SettingsViewController.doColor, colorHue: SettingsViewController.hue)
    }
    
    @IBAction func reset(_ sender: Any) {
        SettingsViewController.upperBound = 100
        upperBoundField.text = String(SettingsViewController.upperBound)
        SettingsViewController.wins = 0
        winCount.text = String(SettingsViewController.wins)
        SettingsViewController.losses = 0
        loseCount.text = String(SettingsViewController.losses)
        doColorize.isOn = false
        SettingsViewController.doColor = false
        colorHue.value = 0.5
        SettingsViewController.hue = 0.5
        self.view.backgroundColor = UIColor.white
        Storage.push(upperBound: SettingsViewController.upperBound, wins: SettingsViewController.wins, losses: SettingsViewController.losses, isColorized: SettingsViewController.doColor, colorHue: SettingsViewController.hue)
    }

    @IBAction func colorSet(_ sender: Any) {
        if doColorize.isOn {
            SettingsViewController.hue = colorHue.value
            SettingsViewController.doColor = true
        } else {
            SettingsViewController.doColor = false
        }
        if SettingsViewController.doColor {
            self.view.backgroundColor = UIColor.init(hue: CGFloat(SettingsViewController.hue), saturation: 1, brightness: 1, alpha: 1)
        } else {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
