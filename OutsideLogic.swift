//
//  OutsideLogic.swift
//  Puzzled Pirates
//
//  Created by Markus Barrow on 25/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation

class OutsiderLogic
{
    
    public func gameTitle() -> String {
        return "Which one does not belong?";
    }
    
    var roundArray: [OutsiderRound]? = nil;
    var numberOfRounds: Int = 0;
    var roundCounter: Int = 0;
    
    init() {
        let tuple = self.makeRounds2()
        roundArray = tuple.0;
        numberOfRounds = tuple.1;
    }
    
    func makeRounds2() -> ([OutsiderRound], Int) {
        let outsiderRound = OutsiderRound.init(outsider: "Plane", matchingWords: ["Cat", "Dog", "Bird"]);
        let outsiderRound2 = OutsiderRound.init(outsider: "Brown", matchingWords: ["Blue", "Yellow", "Red"]);
        let outsiderRound3 = OutsiderRound.init(outsider: "Human", matchingWords: ["Mosquito", "Dragonfly", "Fly"]);
        let outsiderRound4 = OutsiderRound.init(outsider: "Cola", matchingWords: ["Ham", "Cheese", "Egg"]);
        let outsiderRoundArray = [outsiderRound, outsiderRound2, outsiderRound3, outsiderRound4]
        
        return (outsiderRoundArray, outsiderRoundArray.count)
    }
    
    
}
