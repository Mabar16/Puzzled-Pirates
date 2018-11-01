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
    
    func makeRounds() -> [String: [String]]{
        let outsiderRounds =
            ["Car": ["Cat", "Dog", "Bird"],
             "White": ["Red","Yellow","Blue"] ]
        
        return outsiderRounds
    }
    
    
}
