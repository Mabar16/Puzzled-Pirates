//
//  SharedValues.swift
//  Puzzled Pirates
//
//  Created by Jonas Rasmussen on 19/11/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation
import MapKit

class SharedValues{
    static var annotation = MKPointAnnotation()
    static var points : [MKPointAnnotation] = []
    static var nextPuzzle = false
    
    static func popFirst() -> MKPointAnnotation {
        print("HI")
        return points.removeFirst()
    }
    
    static func addPoint(point : MKPointAnnotation){
        points.append(point)
    }
    
    static func getSize() -> Int {
        return points.count
    }
    
    static func getIfNextPuzzle() -> Bool{
        return nextPuzzle
    }
    
    static func goToNextPuzzle(boolean : Bool) {
        nextPuzzle = boolean
    }
}
