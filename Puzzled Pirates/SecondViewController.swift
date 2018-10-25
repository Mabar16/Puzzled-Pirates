//
//  SecondViewController.swift
//  Puzzled Pirates
//
//  Created by Markus Barrow on 11/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var puzzleLabel: UILabel!
    @IBOutlet weak var puzzleImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puzzleLabel?.text = labelText()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showPuzzle() {
        puzzleLabel?.isHidden = !checkLocation()
    }
    
    func labelText() -> String {
        if checkLocation() {
            return "X's and O's"
        } else {
            return "Please find the right location"
        }
    }
    
    func checkLocation() -> Bool {
        return false
    }
}

