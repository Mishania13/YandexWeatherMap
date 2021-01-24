//
//  LocationManager.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 16.01.2021.
//

import CoreLocation

struct LocationManager {
    
    func getCoordinate(forCity cityName: String, comlitionHandler: @escaping(Cordinates2DString)->()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            guard let placemarks = placemarks,  let location = placemarks.first?.location?.coordinate else {
                return
            }
            let locationCoordinate = Cordinates2DString(latitude: location.latitude.description,
                                                    longitude: location.longitude.description)
            comlitionHandler(locationCoordinate)
        }
    }
    
    
}
