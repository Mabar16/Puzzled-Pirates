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
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        print("OHIO GOZAIMASUUUUU")
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.9, longitude: -122.6)
        mapView.addAnnotation(annotation)
        
        
        
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
    
    public static func atPuzzleLocation() -> Bool {
        let number = Int.random(in: 0 ..< 10)
        if (number > 5){
            return true
        }
        return false
    }

    
}

extension MapKitViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        // MARK: - printing distances
        print("PLAYER LATITUDE: \(location.coordinate.latitude)")
        print("PLAYER LONGTITUDE: \(location.coordinate.longitude)")
        print("POINT LATITUDE: \(annotation.coordinate.latitude)")
        print("POINT LONGTITUDE: \(annotation.coordinate.longitude)")
        let converted = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        print("BIG DICK DISTANCE?: \(location.distance(from: converted))")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
