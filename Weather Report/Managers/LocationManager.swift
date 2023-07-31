//
//  LocationManager.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    
    private var coreLocationManager: CLLocationManager = .init()
    
    override init() {
        super.init()
        coreLocationManager.delegate = self
    }
    
    func setupPermission() {
        
        switch coreLocationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted, .notDetermined, .denied:
            coreLocationManager.requestWhenInUseAuthorization()
        @unknown default:
            coreLocationManager.requestWhenInUseAuthorization()
        }
    }
    
    func getCurentLocation() {
        DispatchQueue.global(qos: .userInitiated).async {
            if CLLocationManager.locationServicesEnabled() {
                self.coreLocationManager.requestLocation()
                self.coreLocationManager.startUpdatingLocation()
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.first {
            self.location = lastLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        Log(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        Log(manager.authorizationStatus.rawValue)
    }
}
