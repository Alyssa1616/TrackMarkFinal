//GetLocation.swift
import Foundation
import MapKit
import SwiftUI
import CoreLocation
 
class CurrentLocationFinder: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    func setup() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        let location = locationManager.location
        return location?.coordinate ?? CLLocationCoordinate2DMake(0.0, 0.0)
    }
}
