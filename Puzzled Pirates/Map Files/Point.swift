//
//  Point.swift
//  Puzzled Pirates
//
//  Created by Mikkel on 18/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation

class Point {
    
    private(set) var x: Double
    private(set) var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public func distanceFrom(otherPoint: Point) -> Double {
        return ((x-otherPoint.x)*(x-otherPoint.x)+(y-otherPoint.y)*(y-otherPoint.y)).squareRoot()
    }
    
}
