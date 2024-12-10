//
//  LocationModel.swift
//  iOSProject
//
//  Created by Josh on 12/10/24.
//

//
//  CoreLocationVM.swift
//  CitySight
//
//  Created by David Zhang on 11/12/24.
//

import Foundation

import CoreLocation

class LocationModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    
        
    var locationManager = CLLocationManager() // create a location manager to request permission from user
    @Published var currentLocation : CLLocationCoordinate2D? = nil // save user's current location
    
    override init(){
        super.init()
        locationManager.delegate = self // assign BM to locationManager as its delegate
    }
    
    func getUserLocation(){
        // Check if we have the permission
        if locationManager.authorizationStatus == .authorizedWhenInUse{
            currentLocation = nil
            locationManager.requestLocation()
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // detect if user allowed, then request location
        if manager.authorizationStatus == .authorizedWhenInUse{
            currentLocation = nil
            manager.requestLocation()
        }
//        switch manager.authorizationStatus{
//        case .authorizedAlways:
//        case .notDetermined:
//        case .denied:
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations.first?.coordinate
        // print(locations.last?.coordinate)
        if currentLocation == nil {
            currentLocation = locations.last?.coordinate
        }
        locationManager.stopUpdatingLocation() // needs it once
    }
    
}
