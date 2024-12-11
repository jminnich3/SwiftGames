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
    
    @Published var users = [UserModel]()
    @Published var user : UserModel? = nil
        
    var locationManager = CLLocationManager()     // create a location manager to request permission from user
    @Published var currentLocation : CLLocationCoordinate2D? = nil // save user's current location
    
    override init(){
        super.init()
        locationManager.delegate = self // assign BM to locationManager as its delegate
    }
    
    func getUserLocation(){
         //Check if we have the permission
//        if locationManager.authorizationStatus == .authorizedWhenInUse{
//            currentLocation = nil
//            locationManager.requestLocation()
//        }else{
//            locationManager.requestWhenInUseAuthorization()
//        }
//        
        print("Checking location authorization status...")
            let status = locationManager.authorizationStatus
            
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                print("Authorization granted, requesting location.")
                currentLocation = nil
                locationManager.requestLocation()
            } else if status == .notDetermined {
                locationManager.requestLocation()
                print("Requesting authorization.")
                locationManager.requestWhenInUseAuthorization()
                print("\(currentLocation)")
            } else {
                print("Authorization denied/restricted.")
            }
        
//        let status = CLLocationManager.authorizationStatus()
//            
//            if status == .authorizedWhenInUse || status == .authorizedAlways {
//                currentLocation = nil
//                locationManager.requestLocation()
//            } else if status == .notDetermined {
//                locationManager.requestWhenInUseAuthorization()
//            } else {
//                print("Location access denied or restricted.")
//            }
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
//            case .authorizedAlways:
//            case .notDetermined:
//            case .denied:
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
