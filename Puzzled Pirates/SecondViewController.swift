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
    
    var gameTimer: Timer!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkLocation), userInfo: nil, repeats: true)
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
    
    @objc func checkLocation() -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.puzzleLabel?.text = self.labelText()
            print("Skrrate Potate")
        }
        return MapKitViewController.atPuzzleLocation()
        
    }
}

