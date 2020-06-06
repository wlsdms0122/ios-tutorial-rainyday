//
//  LocationService.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    private let locationManager: CLLocationManager = CLLocationManager()
    private var completed: ((Result<CLLocation, Error>) -> Void)?
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getLocation(completed: @escaping (Result<CLLocation, Error>) -> Void) {
        self.completed = completed
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        guard let completed = completed else { return }
        self.completed = nil
        
        guard let location = locations.first else {
            completed(.failure(RDError.unknown))
            return
        }
        completed(.success(location))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.requestWhenInUseAuthorization()
    }
}
