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
    
    let THRESHOLD_IN_METERS = 30.0
    
    public func checkIfWithinThreshold(onePoint: CLLocation, secondPoint: CLLocation)-> Bool{
        if(onePoint.distance(from: secondPoint) <= THRESHOLD_IN_METERS){
            return true
        }
        return false
    }
    
    //SDU Locations
    //55.367379,10.430793
    //55.367277,10.429900
    //55.367527,10.428386
    func sdu() {
        let firstPoint = MKPointAnnotation()
        let secondPoint = MKPointAnnotation()
        let thirdPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude:55.367379, longitude: 10.430793)
        secondPoint.coordinate = CLLocationCoordinate2D(latitude:55.367379, longitude: 10.430793)
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude:55.367379, longitude: 10.430793)
        SharedValues.addPoint(point: firstPoint)
        SharedValues.addPoint(point: secondPoint)
        SharedValues.addPoint(point: thirdPoint)
    }
    
    func sduDifferent() {
        let firstPoint = MKPointAnnotation()
        let secondPoint = MKPointAnnotation()
        let thirdPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude:55.367379, longitude: 10.430793)
        secondPoint.coordinate = CLLocationCoordinate2D(latitude:55.367277, longitude: 10.429900)
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude:55.367527, longitude: 10.430793)
        SharedValues.addPoint(point: firstPoint)
        SharedValues.addPoint(point: secondPoint)
        SharedValues.addPoint(point: thirdPoint)
    }
    
    func sanFrancisco() {
        let firstPoint = MKPointAnnotation()
        let secondPoint = MKPointAnnotation()
        let thirdPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude:37.78583400, longitude: -122.40641700)
        secondPoint.coordinate = CLLocationCoordinate2D(latitude:37.78583400, longitude: -122.40641700)
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude:37.78583400, longitude: -122.40641700)
        SharedValues.addPoint(point: firstPoint)
        SharedValues.addPoint(point: secondPoint)
        SharedValues.addPoint(point: thirdPoint)
    }
    
    func sanFranciscoDifferent() {
        let firstPoint = MKPointAnnotation()
        let secondPoint = MKPointAnnotation()
        let thirdPoint = MKPointAnnotation()
        firstPoint.coordinate = CLLocationCoordinate2D(latitude:37.78583400, longitude: -122.40641700)
        secondPoint.coordinate = CLLocationCoordinate2D(latitude:55.367277, longitude: 10.429900)
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude:55.367527, longitude: 10.428386)
        SharedValues.addPoint(point: firstPoint)
        SharedValues.addPoint(point: secondPoint)
        SharedValues.addPoint(point: thirdPoint)
    }
    
}
