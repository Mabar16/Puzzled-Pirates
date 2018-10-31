//
//  MapLogic.swift
//  Puzzled Pirates
//
//  Created by Mikkel on 18/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation
import MapKit


class MapLogic {
    
    var point = MKMapPoint(x: 1.0, y: 1.0)
    let list = [MKMapPoint]()
    
    let THRESHOLD_IN_METERS = 15.0
    
    public func checkIfWithinThreshold(onePoint: CLLocation, secondPoint: CLLocation)-> Bool{
        if(onePoint.distance(from: secondPoint) <= THRESHOLD_IN_METERS){
            return true
        }
        return false
    }
    
    
}
