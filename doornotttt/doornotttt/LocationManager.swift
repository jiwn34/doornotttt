// 📍 LocationManager.swift - 현재 위치를 가져오는 싱글톤

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let manager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location.coordinate
            manager.stopUpdatingLocation()
        }
    }
}
