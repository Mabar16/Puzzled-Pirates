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
    lazy var roundCounter: Int = outsiderGame.roundCounter
    lazy var outsiderRound = outsiderGame.nextOutsiderRound()
    var playerIsAtLocation: Bool = false;
    
    @IBOutlet weak var puzzleLabel: UILabel!
    @IBOutlet var uiButtons: [UIButton]!
    @IBOutlet weak var treasureImage: UIImageView!
    
    
    func hideButtons(_ hide: Bool) {
        if(!outsiderGame.isRoundOver()){
            for button in uiButtons{
                button.isHidden = hide
            }
            if (!hide) {
                puzzleLabel.text = outsiderGame.gameTitle()
            } else {
                puzzleLabel.text = "Please find the right location"
            }
        } else {
            for button in uiButtons{
                button.isHidden = true
            }
        }
    }
    
    
    

    @IBAction func buttonPressed(_ sender: UIButton) {
            if !(sender as AnyObject).isHidden {
                print("pressed")
                if ((sender as UIButton).currentTitle == outsiderRound.outsider) {
                    print("nice one, champ")
                    roundCounter = outsiderGame.incrementRoundCounter();
                    if (!outsiderGame.isRoundOver()){
                        SharedValues.goToNextPuzzle(boolean: true)
                        outsiderRound = outsiderGame.nextOutsiderRound();
                        buttonsAreShuffled = false;
                        hideButtons(true)
                    } else {
                        hideButtons(outsiderGame.isRoundOver())
                        treasureImage.isHidden = false
                        puzzleLabel.text = "You found the treasure!"
                    }
                    // Tab to map
                    tabBarController?.selectedIndex = 0
                }
            }
    }
    
    
    var gameTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPuzzle();
        gameTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(checkLocation), userInfo: nil, repeats: true)
    }
    
    lazy var buttonsAreShuffled: Bool = false;
    
    func showPuzzle() {
        if (!buttonsAreShuffled){
        var list = outsiderRound.matchingWords;
        list.append(outsiderRound.outsider);
        list.shuffle();
        buttonsAreShuffled = true
        for (index, element) in uiButtons.enumerated() {
            if (index < 4){
                element.setTitle(list[index], for: UIControl.State.normal)
            }
        }
        }
    }
    
    @objc func checkLocation(){
        DispatchQueue.main.async(){}
        playerIsAtLocation = SharedValues.getIfAtLocation()
        hideButtons(!playerIsAtLocation)
        if(playerIsAtLocation){
            showPuzzle()
        }
    }
}

