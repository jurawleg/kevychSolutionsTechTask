//
//  LocationManager.swift
//  Weather Report
//
//  Created by MacBook on 27.07.2023.
//

import Foundation
import CoreLocation

@MainActor class LocationManager: NSObject {
    
    @Published var location: CLLocation?
    
    static let shared: LocationManager = .init()
    
    private var coreLocationManager: CLLocationManager = .init()
    
    private override init() { }
    
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
        coreLocationManager.requestLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.first {
            self.location = lastLocation
        }
    }
}
