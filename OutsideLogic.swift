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
    public func getGame() -> (String, [String]){
        if let x = makeRounds()["Car"] {
            return ("Car", x);
        }
        
        return ("Error", ["I", "Suck"])
    }
    
    public func gameTitle() -> String {
        return "Which one does not belong?";
    }
    
    func makeRounds2() -> [OutsiderRound]{
        var outsiderRound = OutsiderRound.init(outsider: "Plane", matchingWords: ["Cat", "Dog", "Bird"]);
        var outsiderRoundArray = [outsiderRound]
        
        return outsiderRoundArray
    }
    
    
}
