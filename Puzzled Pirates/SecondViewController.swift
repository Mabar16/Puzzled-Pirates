//
//  SecondViewController.swift
//  Puzzled Pirates
//
//  Created by Markus Barrow on 11/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let outsiderGame = OutsiderLogic()
    
    lazy var outsiderRoundArray = outsiderGame.makeRounds2()
    
    lazy var outsiderRound = outsiderRoundArray[0]
    
    @IBOutlet weak var puzzleLabel: UILabel!
    @IBOutlet var uiButtons: [UIButton]!
    

    @IBAction func buttonPressed(_ sender: UIButton) {
            if !(sender as AnyObject).isHidden {
                print("pressed")
                if ((sender as UIButton).currentTitle == outsiderRound.outsider) {
                    print("lol nice one, champ")
                }
            }
    }
    
    
    var gameTimer: Timer!
    
    let MKVC = MapKitViewController()
    
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(checkLocation), userInfo: nil, repeats: true)
        for button in uiButtons{
            button.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func showPuzzle(_ atLoc: Bool) {
        //puzzleImage?.isHidden = atLoc
        //
        //uiButtons.shuffle()
        for button in uiButtons{
            button.isHidden = !atLoc
        }
        
        for (index, element) in uiButtons.enumerated() {
            if (index < 3){
                element.setTitle(outsiderRound.matchingWords[index], for: UIControl.State.normal)
            } else {
                element.setTitle(outsiderRound.outsider, for: UIControl.State.normal)
            }
        }
        
        /*
        for (index, element) in uiButtons.enumerated() {
            if (index < 3){
            element.setTitle(values.1[index], for: UIControl.State.normal)
            } else {
            element.setTitle(values.0, for: UIControl.State.normal)
            }
        }*/

        
    }
    
    func labelText() -> String {
        if checkLocation() {
            return outsiderGame.gameTitle()
        } else {
            return "Please find the right location"
        }
    }
    
    @objc func checkLocation() -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.puzzleLabel?.text = self.labelText()
        }
        let atLoc = true; //MKVC.atPuzzleLocation()
        showPuzzle(atLoc);
        return atLoc;
        
    }
}

