//
//  ViewController.swift
//  Guessing Game iOS
//
//  Created by Solomon Keiffer on 9/21/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var guessAmt: UIProgressView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var announce: UILabel!
    
    var randNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randNo = Int.random(in: 1...100)
    }

    @IBAction func Guess(_ sender: Any) {
        guard announce.text != "Try Again?" && announce.text != "Correct" else {
            button.setTitle("Guess", for: .normal)
            announce.text = ""
            randNo = Int.random(in: 1...100)
            guessAmt.progress = 1
            numberField.text = ""
            self.view.backgroundColor = UIColor.white
            return
        }
        
        if self.view.backgroundColor != UIColor.white {
            self.view.backgroundColor = UIColor.white
        }
        
        if button.title(for: .normal) != "Guess" {
            button.setTitle("Guess", for: .normal)
        }
        
        guard let guess = Int(numberField.text!) else {
            self.view.backgroundColor = UIColor.red
            button.setTitle("Guess A Number", for: .normal)
            return
        }
        
        if guess == randNo {
            self.view.backgroundColor = UIColor.green
            announce.text = "Correct"
        } else if guess > randNo {
            guessAmt.progress -= 0.125
            announce.text = "Too High"
        } else {
            guessAmt.progress -= 0.125
            announce.text = "Too Low"
        }
        
        if guessAmt.progress == 0 {
            self.view.backgroundColor = UIColor.red
            announce.text = "Try Again?"
            button.setTitle("Retry?", for: .normal)
        }
        
        if announce.text == "Correct" {
            button.setTitle("Play Again?", for: .normal)
        }
    }
}

