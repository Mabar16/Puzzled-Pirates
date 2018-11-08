//
//  OutsiderStruct.swift
//  Puzzled Pirates
//
//  Created by Markus Barrow on 25/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation

struct OutsiderRound
{
    let outsider : String
    let matchingWords : [String]
    
    init(outsider: String,matchingWords: [String]){
        self.outsider = outsider;
        self.matchingWords = matchingWords;
    }
}
