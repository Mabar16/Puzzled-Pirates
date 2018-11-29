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
    let regionInMeters: Double = 500
    var annotation = MKPointAnnotation()
    var points : [MKPointAnnotation] = []
    let gameLogic = MapLogic()
    var playerLocationPoint = CLLocation()
    var gameTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()

        //Choose one map
        //gameLogic.sanFrancisco()
        //gameLogic.sanFranciscoDifferent()
        //gameLogic.sdu()
        gameLogic.sduDifferent()
        
        annotation = SharedValues.popFirst()
        mapView.addAnnotation(annotation)
        
        gameTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(atPuzzleLocation), userInfo: nil, repeats: true)
    }
    
    
    func setPlayerLocation(playerLocation : CLLocation) {
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
        SharedValues.goToNextPuzzle(boolean: false)
        print(SharedValues.getSize())
        if(SharedValues.getSize() > 0){
            mapView.removeAnnotation(annotation)
            annotation = SharedValues.popFirst()
            mapView.addAnnotation(annotation)
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
            displayGPSErrorMessage(message: "You have denied gps acccess.\nPlease correct in your settings")
            break
        case .restricted:
            displayGPSErrorMessage(message: "Parental controls are enabled.\nPlease contact the owner")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func displayGPSErrorMessage(message: String) {
        let alertController = UIAlertController(title: "GPS Settings Error", message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension MapKitViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        let converted = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let convertedTwo = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("DISTANCE: \(location.distance(from: converted))")
        print(gameLogic.checkIfWithinThreshold(onePoint: convertedTwo, secondPoint: converted))
        setPlayerLocation(playerLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    @objc func atPuzzleLocation(){
        DispatchQueue.main.async(){}
        let converted = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)

        //Used for SharedValues
        SharedValues.setIfAtLocation(boolean: gameLogic.checkIfWithinThreshold(onePoint: converted, secondPoint: playerLocationPoint))
        
        if(SharedValues.getIfNextPuzzle()){
            nextPuzzle()
        }
    }
    
}
