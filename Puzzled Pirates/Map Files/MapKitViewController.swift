//
//  MapKitViewController.swift
//  Puzzled Pirates
//
//  Created by Mikkel on 18/10/2018.
//  Copyright © 2018 University of Southern Denmark. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    static var annotation = MKPointAnnotation()
    static var points : [MKPointAnnotation] = []
    let gameLogic = MapLogic()
    static var playerLocationPoint = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        print("OHIO GOZAIMASUUUUU")
        
        let firstPoint = MKPointAnnotation()
        let secondPoint = MKPointAnnotation()
        let thirdPoint = MKPointAnnotation()
    
        firstPoint.coordinate = CLLocationCoordinate2D(latitude:37.78583400, longitude: -122.40641700)
        secondPoint.coordinate = CLLocationCoordinate2D(latitude:37.78584400, longitude: -122.40641700)
        thirdPoint.coordinate = CLLocationCoordinate2D(latitude:37.78585400, longitude: -122.40641700)
        
        MapKitViewController.points.append(firstPoint)
        MapKitViewController.points.append(secondPoint)
        MapKitViewController.points.append(thirdPoint)
        
        MapKitViewController.annotation = MapKitViewController.points.removeFirst()
        mapView.addAnnotation(MapKitViewController.annotation)
    }
    
    static func setPlayerLocation(playerLocation : CLLocation) {
        playerLocationPoint = playerLocation
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // no allowed to locate
        }
    }
    
    func nextPuzzle() {
        if(MapKitViewController.points.count > 0){
            //mapView.removeAnnotation(MapKitViewController.annotation)
            MapKitViewController.annotation = MapKitViewController.points.removeFirst()
            //mapView.addAnnotation(MapKitViewController.annotation)
        } else {
            print("BOB, DO SOMETHING!")
        }
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            break
        case .denied:
            // show instruction how fix
            break
        case .restricted:
            // show that there's parental controls enabled
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
            
        }
        
        
        
    }
    
}

extension MapKitViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        // MARK: - printing distances
        print("PLAYER LATITUDE: \(location.coordinate.latitude)")
        print("PLAYER LONGTITUDE: \(location.coordinate.longitude)")
        print("POINT LATITUDE: \(MapKitViewController.annotation.coordinate.latitude)")
        print("POINT LONGTITUDE: \(MapKitViewController.annotation.coordinate.longitude)")
        let converted = CLLocation(latitude: MapKitViewController.annotation.coordinate.latitude, longitude: MapKitViewController.annotation.coordinate.longitude)
        let convertedTwo = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("BIG DICK DISTANCE?: \(location.distance(from: converted))")
        print(gameLogic.checkIfWithinThreshold(onePoint: convertedTwo, secondPoint: converted))
        MapKitViewController.setPlayerLocation(playerLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func atPuzzleLocation() -> Bool {
        
        let converted = CLLocation(latitude: MapKitViewController.annotation.coordinate.latitude, longitude: MapKitViewController.annotation.coordinate.longitude)
//        let convertedTwo = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("called")
        print(gameLogic.checkIfWithinThreshold(onePoint: MapKitViewController.playerLocationPoint, secondPoint: converted))
        print("PLAYER LAT: \(MapKitViewController.playerLocationPoint.coordinate.latitude) PLAYER LONG: \(MapKitViewController.playerLocationPoint.coordinate.longitude)")
        print("POINT LAT: \(converted.coordinate.latitude) POINT LONG: \(converted.coordinate.longitude)")
        
        return gameLogic.checkIfWithinThreshold(onePoint: converted, secondPoint: MapKitViewController.playerLocationPoint)
    }
    
}
