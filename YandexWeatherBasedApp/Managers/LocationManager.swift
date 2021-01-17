//
//  LocationManager.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import CoreLocation

struct LocationConverter {
    
    static let shared = LocationConverter()
    
//    func coordinateToPlaceName(withLongitude lon: String, andLatitude lat: String, clousure: @escaping(String)->()) {
//
//        guard let _ = Double(lon) else {
//            print ("longitude is wrong")
//            return
//        }
//        guard let _ = Double(lat) else {
//            print ("latitude is wrong")
//            return
//        }
//
//        let center = CLLocationCoordinate2D(latitude: Double(lon)!, longitude: Double(lat)!)
//        let geocoder = CLGeocoder()
//        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
//
//        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
//
//            if let error = error {
//                print("Revers grocoder error \(error.localizedDescription)")
//            }
//            let pm = placemark! as [CLPlacemark]
//            if pm.count > 0 {
//                let pm = placemark![0]
//                if let locality = pm.locality {
//                    clousure(locality)
//                }
//            }
//        }
//    }
    
    func getCoordinate(forCity cityName: String, coordinate: @escaping([String])->()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            guard let placemarks = placemarks,  let location = placemarks.first?.location?.coordinate else {
                return
            }
            let locationString = [location.latitude.description, location.longitude.description]
            coordinate(locationString)
        }
    }
}
